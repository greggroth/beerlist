class ImportPorter
  # require "nokogiri"
  # require "open-uri"
  # require "yaml"
  
  def self.load_list(url)
    #  Let's check out The Porter's selection
    doc = Nokogiri::HTML(open(url))
    
    dat = Array.new

    #  Fill the array with the data from each row
    doc.css('tr').each { |row| dat << row.content.delete("\t").split(/\n/) }

    #  Remove the heading 
    return dat.drop(2)
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
  def save_to_db(beer_list)
    bar = Bar.find_by_name("The Porter Beer Bar")
    existing_items = BeerItem.where("bar_id = ?", bar.id).map { |i| i.beer.name }
    existing_beers = Beer.all.map { |i| i.name }
    existing_breweries = Brewery.all.map { |i| i.name }
    
    beer_list.each do |listing|
      # Check if the beer/bar combination already exists
      if existing_items.include? listing[1]
        return
      end
      # if not, check that the beer exists.  If so, make the item
      if existing_beer.include? listing[1]
        # MAKE THE ITEM
      else
        # if not, check that the brewery exists.  If so, make the beer and the item
        if exisiting_breweries.include? listing[0]
          # MAKE THE BEER
          # MAKE THE ITEM
        else
          # MAKE THE BREWERY
          brewy = Brewery.new :name => listing[0]
          brewy.save!
          # MAKE THE BEER
          bubs = brewy.beer.new :name => listing[1], :abv => listing[5]
          bubs.save!
          # MAKE THE ITEM
          bar.beer_items.new :beer => bubs
        end
      end
    end
    
  end
  
end

beers = ImportPorter.load_list('http://www.theporterbeerbar.com/drink/beer/')

#  Save the data
out = File.new("porter_beer_menu.yml", "w")
out.write(beers.to_yaml)

#  Give the user a notice
puts "Found #{beers.count} listings and wrote the array to 'porter_beer_menu.yml'"