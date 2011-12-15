class ImportBrickstore
  require "nokogiri"
  require "open-uri"
  require "yaml"
  require "enumerator"
  require "active_support"
  
  def self.load_list(url)
    #  Let's check out The Porter's selection
    doc = Nokogiri::HTML(open(url))

    #  Fill the array with the data from each row
    dat = doc.css('td').map { |r| r.content }.drop(2).map { |n| n.class == String ? n.titleize : n }.enum_for(:each_slice, 8).to_a

    #  Compensate for how they have seperate downstairs/belgian bar lists
    downstairs = dat.take_while { |i| i[0] != " " }
    belgianbar = (dat-downstairs).flatten.drop(2).enum_for(:each_slice, 8).to_a
    belgianbar.pop

    full_list = downstairs + belgianbar
    
    return full_list
  end
  
  def self.fix_volume(in_volume)
    return Array.new(3) if in_volume.nil? or in_volume.empty?
     
    volume = in_volume.delete(" ").split(/(\d+)/)
    if volume.length == 3
      volume[1] = (volume[0] == ".") ? ["0", volume[0], volume[1]].join : [volume[0], volume[1]].join
    end
    if (volume.length == 4) or (volume.length == 5)  # there was a decimal or decimal+unit
      corrected = [volume[1], volume[2], volume[3]].join
      volume[1] = corrected
    end
    case volume.last.downcase
    when "L"
      volume[1] = (volume[1].to_f*1000).to_i
      volume[2] = "ml"
    when "oz", "ml", "cl"
      volume[2] = volume.last.downcase
    else
      volume[2] = "oz"
    end
    return volume.take(3)
  end
  
  # Brickstore keeps their list in the format:
  #  0  - Brewery/Beer
  #  1  - Style
  #  2  - City, State
  #  3  - Volume
  #  4  - ABV
  #  5  - Price

  def self.update_db(beer_list, pouring)
    bar = Bar.find_by_name("Brick Store Pub")
    brewery_names = Brewery.all.map(&:name)
    
    
    beer_list.each do |listing|
      puts "---------------"
      puts "checking:  #{listing[0]}"
      listing.map(&:strip)
      
      brewery_name = brewery_names.select { |i| listing[0].include? i }.first
      if brewery_name.nil?
        puts "**  BREWERY COULD NOT BE DETERMINED  **"
        next
      end
      
      # remove parentheses, the brewery's name, and any possessive 's
      beer_name = listing[0].delete("()").gsub(brewery_name, "").gsub("'s","").strip
      beer_name = brewery_name if beer_name.empty?
      price = listing[5].delete("$").to_f    
      brewy = Brewery.find_by_name(brewery_name)
      bubs = Beer.where(name: beer_name, brewery_id: brewy.id).first
      if not bubs.nil?
        updating_item = BeerItem.where(bar_id: bar.id, beer_id: bubs.id).first
        if updating_item.present?
          #  Updates the existing record to make sure it's up to date
          puts "updating the listing for #{beer_name}"
          volume = fix_volume(listing[3])
          v = volume[1].nil? ? nil : volume[1].to_f
          BeerItem.update(updating_item.id, pouring: pouring, volume: v, volunit: volume[2], price: price, updated_at: Time.now)
          next
        end
      else
        # Check beer styles
        style = BeerStyle.find_or_create_by_name(listing[1])
      
        # MAKE THE BEER
        unless beer_name.strip.empty?
          puts "adding beer:  #{beer_name}"
          bubs = brewy.beers.new name: beer_name, abv: listing[4].to_f, beer_style: style
          bubs.save!
        end
      end
      # MAKE THE ITEM
      puts "creating new listing for #{listing[0]}"
      volume = fix_volume(listing[3])
      v = volume[1].nil? ? nil : volume[1].to_f
      new_item = bar.beer_items.new beer: bubs, volume: v, volunit: volume[2], pouring: pouring, price: price
      new_item.save!
    end
    
  end
end

bottles = ImportBrickstore.load_list('http://www.brickstorepub.com/bottledbeer/')
draught = ImportBrickstore.load_list('http://www.brickstorepub.com/draughtbeer/')

ImportBrickstore.update_db(bottles, "bottle")
ImportBrickstore.update_db(draught, "draught")
  
ActionController::Base.new.expire_fragment("list_of_beer_items_14")
ActionController::Base.new.expire_fragment("bar_details_14")

# puts "found #{bottles.count} in bottles"
# bout = File.new("brickstore_bottle_menu.yml", "w")
# bout.write(bottles.to_yaml)
# 
# puts "found #{draught.count} beers on draught"
# dout = File.new("brickstore_draught_menu.yml", "w")
# dout.write(draught.to_yaml)