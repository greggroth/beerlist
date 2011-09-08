require 'spec_helper'

describe "BeerItems" do
  it "logs in and makes a new listing" do
    user = FactoryGirl.create(:user)
    bar = FactoryGirl.create(:bar)
    beer = FactoryGirl.create(:beer)
    
    visit root_path
    click_link "Login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_beer_item_path
    fill_in "Volume", :with => "12"
    fill_in "Price", :with => "4.00"
    click_button "Submit"
    current_path.should eq(beer_items_path)
    page.should have_content "Beer listing added"
  end
  
  it "views beer item listing" do
    user = FactoryGirl.create(:user)
    bar = FactoryGirl.create(:bar)
    beer = FactoryGirl.create(:beer)
    beer_item = FactoryGirl.create(:beer_item, :user_id => user.id, :bar_id => bar.id, :beer_id => beer.id)
 
    visit root_path
    click_link "Login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    click_link "Details"
    page.should have_content "Details"
  end
end
