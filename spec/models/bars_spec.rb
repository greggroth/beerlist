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
  
  it "attempts to duplicate an existing bar" do
    existing_bar = FactoryGirl.create(:bar)
    new_bar = Bar.new(existing_bar.attributes)
    new_bar.should have(1).error_on(:name)
  end
  
  
end