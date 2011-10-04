require 'spec_helper'

describe "BeerItems" do
  it "views the front page with no beeritems added" do
    visit root_path
  end
  
  it "required login before creating a new listing" do
    visit root_path
    click_link "Login"
    current_path.should eq(new_user_session_path)
  end
  
  it "logs in and makes a new listing" do
    user = FactoryGirl.create(:user)
    
    5.times do 
      FactoryGirl.create(:bar)
      FactoryGirl.create(:beer)
    end
    
    bar = FactoryGirl.create(:bar)
    beer = FactoryGirl.create(:beer)
    
    visit root_path
    click_link "Login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_beer_item_path
    select bar.name, :from => "beer_item_bar_id"
    select beer.name, :from => "beer_item_beer_id"
    fill_in "Volume", :with => "12"
    fill_in "Price", :with => "4.00"
    click_button "Submit"
    current_path.should eq(beer_items_path)
    page.should have_content "Beer listing added"
  end
  
  it "attempts to recreate an existing listing" do
    user = FactoryGirl.create(:user)
    bar = FactoryGirl.create(:bar)
    beer = FactoryGirl.create(:beer)
    beer_item = FactoryGirl.create(:beer_item, :user_id => user.id, :bar_id => bar.id, :beer_id => beer.id)
    
    visit root_path
    click_link "Login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_beer_item_path
    select bar.name, :from => "beer_item_bar_id"
    select beer.name, :from => "beer_item_beer_id"
    fill_in "Volume", :with => beer_item.volume
    select beer_item.volunit, :from => "beer_item_volunit"
    fill_in "Price", :with => beer_item.price
    select beer_item.pouring, :from => "beer_item_pouring"
    click_button "Submit"

    current_path.should eq(beer_items_path)
    page.should have_content "Beer and bar combination already exists."
    
  end
  
  # it "views beer item listing" do
  #   user = FactoryGirl.create(:user)
  #   bar = FactoryGirl.create(:bar)
  #   beer = FactoryGirl.create(:beer)
  #   beer_item = FactoryGirl.create(:beer_item, :user_id => user.id, :bar_id => bar.id, :beer_id => beer.id)
  #  
  #   visit root_path
  #   click_link "Login"
  #   fill_in "Email", :with => user.email
  #   fill_in "Password", :with => user.password
  #   click_button "Sign in"
  #   
  #   click_link "Details"
  #   page.should have_content "Details"
  #   page.should have_content bar.name
  #   page.should have_content beer.name
  #   page.should have_content "$4.00"
  #   page.should have_content "12 oz"
  # end
end
