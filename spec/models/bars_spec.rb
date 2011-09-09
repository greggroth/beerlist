require 'spec_helper'

describe "Bars", :type => :model do
  it " creates a new bar" do
    b = Bar.new
    b.name = "TestBar"
    b.address = "1234 John Doe Lane"
    b.city = "Jonetown"
    b.zip = "12345"
    b.state = "GA"
    b.url = "http://www.exampleurl.com"
    b.save!
  end
  
  
end