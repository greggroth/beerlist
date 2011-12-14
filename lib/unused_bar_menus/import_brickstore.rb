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
end

bottles = ImportBrickstore.load_list('http://www.brickstorepub.com/bottledbeer/')
draught = ImportBrickstore.load_list('http://www.brickstorepub.com/draughtbeer/')
  
puts "found #{bottles.count} in bottles"
bout = File.new("brickstore_bottle_menu.yml", "w")
bout.write(bottles.to_yaml)

puts "found #{draught.count} beers on draught"
dout = File.new("brickstore_draught_menu.yml", "w")
dout.write(draught.to_yaml)