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
  
  # the porter keeps their list in the format:
  #     - Brewery
  #     - Beer
  #     - Style
  #     - Origin
  #     - Volume
  #     - ABV
  #     - Description
  #  DOES NOT HAVE PRICE!!!  :-(
  def save_to_db(beer_list)
    
  end
  
end

beers = ImportPorter.load_list('http://www.theporterbeerbar.com/drink/beer/')

#  Save the data
out = File.new("porter_beer_menu.yml", "w")
out.write(beers.to_yaml)

#  Give the user a notice
puts "Found #{beers.count} listings and wrote the array to 'beer_menu.yml'"