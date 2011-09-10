require 'spec_helper'

describe "Beers - " do
  it "goes from root_path to beers index" do
    visit root_path
    click_link "Beers"
    current_path.should eq(beers_path)
  end
  
  it "views a beers page" do
    brewery = FactoryGirl.create(:brewery)
    style = FactoryGirl.create(:beer_style)
    beer = FactoryGirl.create(:beer, :beer_style_id => style.id)
    
    visit beer_path(beer)
    page.should have_content beer.name
    page.should have_link brewery.name, :href => brewery_path(brewery)
    page.should have_content beer.abv
    page.should have_content beer.beer_style.name
  end
  
  it "add a new beer" do
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    5.times do
      FactoryGirl.create(:brewery)
      FactoryGirl.create(:beer)
    end
    style = FactoryGirl.create(:beer_style)

    visit beers_path
    click_link "New Beer"
    fill_in "beer_name", :with => "New Beer"
    select 'brewery4', :from => 'beer_brewery_id'
    select style.name, :from => 'beer_beer_style_id'
    fill_in "beer_abv", :with => "4"
    click_button "Create Beer"
    page.should have_content 'Beer was successfully created.'
  end
end
