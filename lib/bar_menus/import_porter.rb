class ImportPorter
  require "nokogiri"
  require "open-uri"
  require "yaml"
  
  def self.load_list(url)
    #  Let's check out The Porter's selection
    doc = Nokogiri::HTML(open(url))
    
    dat = Array.new

    #  Fill the array with the data from each row
    doc.css('tr').each { |row| dat << row.content.delete("\t").split(/\n/) }

    #  Remove the heading 
    return dat.drop(2)
  end

  def self.fix_volume(in_volume)
    volume = in_volume.delete(" ").split(/(\d+)/)
    if volume.length == 3
      volume[1] = (volume[0] == ".") ? ["0", volume[0], volume[1]].join : [volume[0], volume[1]].join
    end
    if (volume.length == 4) or (volume.length == 5)  # there was a decimal or decimal+unit
      corrected = [volume[1], volume[2], volume[3]].join
      volume[1] = corrected
    end
    case volume.last.downcase
    when "l"
      volume[1] = (volume[1].to_f*1000).to_i
      volume[2] = "ml"
    when "oz", "ml", "cl"
      volume[2] = volume.last.downcase
    else
      volume[2] = "oz"
    end
    return volume.take(3)
  end
  
  # the porter keeps their list in the format:
  #  0  - Brewery
  #  1  - Beer
  #  2  - Style
  #  3  - Origin
  #  4  - Volume
  #  5  - ABV
  #  6  - Description
  #  DOES NOT HAVE PRICE!!!  :-(
  def self.update_db(beer_list)
    user = User.find_by_email("admin@atlbeerlist.com")
    bar = Bar.find_by_name("The Porter Beer Bar")
    
    pouring = "draught"
    beer_list.each do |listing|
      # Get rid of leading or trailing whitespace
      listing.map(&:strip)
      
      puts "---------------"
      
      if listing[0] == "Brewery"  
        # skip the key row and set the pouring to bottle 
        pouring = "bottle"
        next
      end
      
      # Check if the beer/bar combination already exists
      puts "checking:  #{listing[1]}"
      
      brewy = Brewery.find_by_name(listing[0])
      if brewy.nil?
        # MAKE THE BREWERY
        puts "adding brewery:  #{listing[0]}"
        brewy = Brewery.new :name => listing[0]
        brewy.save!
      end

      # if not, check that the beer exists.  If so, make the item
      bubs = Beer.where(name: listing[1], brewery_id: brewy.id).first
      if not bubs.nil?
        updating_item = BeerItem.where(bar_id: bar.id, beer_id: bubs.id).first
        if updating_item.present?
          #  Updates the existing record to make sure it's up to date
          puts "updating the listing for #{listing[1]}"
          volume = fix_volume(listing[4])
          BeerItem.update(updating_item.id, user_id: user.id, pouring: pouring, volume: volume[1].to_f, volunit: volume[2], updated_at: Time.now)
          next
        end
      else
        # Check beer styles
        style = BeerStyle.find_by_name(listing[2])
        if style.nil?
          puts "adding style:  #{listing[2]}"
          style = BeerStyle.new name: listing[2]
          style.save!
        end
        # MAKE THE BEER
        puts "adding beer:  #{listing[1]}"
        bubs = brewy.beers.new name: listing[1], abv: listing[5].to_f, beer_style: style
        bubs.save!
      end
      # MAKE THE ITEM
      puts "creating new listing for #{listing[1]}"
      volume = fix_volume(listing[4])
      new_item = bar.beer_items.new user_id: user.id, beer_id: bubs.id, volume: volume[1].to_f, volunit: volume[2], pouring: pouring
      new_item.save!
    end
  end
  
  def self.clean_db
    puts "----------------------"
    puts "Removing old listings"
    puts "----------------------"
    # Removes any beer items that were not updated within the past week (aka not updated by self.update_db)
    bar = Bar.find_by_name("The Porter Beer Bar")
    BeerItem.where("bar_id = ? and updated_at < ?", bar.id, 1.week.ago).each do |i| 
      puts "Removing beer listing for:  #{i.beer.name}"
      i.destroy
    end
  end

  def self.perform
    beers = ImportPorter.load_list('http://www.theporterbeerbar.com/drink/beer/')
    ImportPorter.update_db(beers)
    ImportPorter.clean_db
    ActionController::Base.new.expire_fragment("list_of_beer_items_#{Bar.find_by_name("The Porter Beer Bar").id}")
    ActionController::Base.new.expire_fragment("bar_details_#{Bar.find_by_name("The Porter Beer Bar").id}")
  end
end

ImportPorter.perform