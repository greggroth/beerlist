require 'spec_helper'

describe "Beers - " do
  it "goes from root_path to beers index" do
    visit root_path
    click_link "Beers"
    current_path.should eq(beers_path)
  end
  
  it "add a new beer" do
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Login"
    
    5.times do
      FactoryGirl.create(:brewery)
      FactoryGirl.create(:beer)
    end
    
    beer = FactoryGirl.create(:beer)
    visit beers_path
    click_link "New Beer"
    fill_in "beer_name", :with => beer.name
    select 'brewery2', :from => 'beer_brewery_id'
    fill_in "beer_abv", :with => beer.abv
    click_button "Create Beer"
    page.should have_content 'Beer was successfully created.'
  end
end
