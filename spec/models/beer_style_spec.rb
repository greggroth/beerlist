require 'spec_helper'

describe BeerStyle do
  it "creates a new beer style" do
    b = BeerStyle.new
    b.name = "Style1"
    b.description = "Test Descript"
    b.valid?
  end
  
  it "attempts to create a duplicate beer style" do
    FactoryGirl.create(:beer_style)
    
    b = BeerStyle.new
    b.name = "style1"
    b.description = "Test Descript"
    !b.valid?
    
  end
end
