require 'spec_helper'

describe "Breweries", :type => :model do
  it " creates a new brewery" do
    b = Brewery.new
    b.name = "Testbrewery"
    b.address = "1234 John Doe Lane"
    b.city = "Jonetown"
    b.zip = "12345"
    b.state = "GA"
    b.url = "http://www.exampleurl.com"
    b.save!
  end
  
  
end