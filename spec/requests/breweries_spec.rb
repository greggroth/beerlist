require 'spec_helper'

describe "Brewery" do
  it " goes to brewery index" do
    visit root_path
    click_link "Breweries"
    current_path.should eq(breweries_path)
  end
  
  it "views a brewery page" do
    brewery = FactoryGirl.create(:brewery)
    
    visit brewery_path(brewery)
    page.should have_content brewery.name
    page.should have_content brewery.address
    page.should have_content brewery.zip
    page.should have_content brewery.state
    page.should have_content brewery.city
    page.should have_link "Website", :href => brewery.url
  end
  
  it "creates a new brewery" do 
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_brewery_path
    
    fill_in "brewery_name", :with => "name"
    fill_in "brewery_address", :with => "addy"
    fill_in "brewery_city", :with => "atl"
    fill_in "brewery_state", :with => "GA"
    fill_in "brewery_zip", :with => "30316"
    fill_in "brewery_url", :with => "http://www.tester.com/"
    
    click_button "Create Brewery"
    current_path.should eq(brewery_path(1))
    page.should have_content "Brewery was successfully created."
  end
  
  it "attempts to create a brewery already in the database" do 
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_brewery_path
    brewery = FactoryGirl.create(:brewery)
    
    fill_in "brewery_name", :with => brewery.name
    fill_in "brewery_address", :with => brewery.address
    fill_in "brewery_zip", :with => brewery.zip
    fill_in "brewery_city", :with => brewery.city
    fill_in "brewery_state", :with => brewery.state
    fill_in "brewery_zip", :with => brewery.zip
    fill_in "brewery_url", :with => brewery.url
    
    click_button "Create Brewery"
    current_path.should eq(breweries_path)
    page.should have_content "Name has already been taken"
  end
  
end