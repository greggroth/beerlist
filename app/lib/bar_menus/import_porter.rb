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
    if (volume.length == 4) or (volume.length == 5)  # there was a decimal or decimal+unit
      corrected = [volume[1], volume[2], volume[3]].join
      volume[1] = corrected
      volume[2] = ["oz", "ml", "cl"].include?(volume.last) ? volume.last : "oz"
    end
    return volume
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
  def self.save_to_db(beer_list)
    bar = Bar.find_by_name("The Porter Beer Bar")
    
    pouring = "draught"
    beer_list.each do |listing|
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
          volume = fix_volume(listing[4])
          BeerItem.update(updating_item.id, :pouring => pouring, :volume => volume[1].to_f, :volunit => volume[2])
          next
        end
      else
        # Check beer styles
        style = BeerStyle.find_by_name(listing[2])
        if style.nil?
          puts "adding style:  #{listing[2]}"
          style = BeerStyle.new :name => listing[2]
          style.save!
        end
        # MAKE THE BEER
        puts "adding beer:  #{listing[1]}"
        bubs = brewy.beers.new :name => listing[1], :abv => listing[5].to_f, :beer_style => style
        bubs.save!
      end
      # MAKE THE ITEM
      volume = fix_volume(listing[4])
      new_item = bar.beer_items.new :beer => bubs, :volume => volume[1].to_f, :volunit => volume[2], :pouring => pouring
      new_item.save!
    end
  end

end

beers = ImportPorter.load_list('http://www.theporterbeerbar.com/drink/beer/')
ImportPorter.save_to_db(beers.take(50))

# #  Save the data
# out = File.new("porter_beer_menu.yml", "w")
# out.write(beers.to_yaml)
# 
# #  Give the user a notice
# puts "Found #{beers.count} listings and wrote the array to 'porter_beer_menu.yml'"