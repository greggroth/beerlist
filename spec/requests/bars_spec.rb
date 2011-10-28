require 'spec_helper'

describe "Bars" do 
  it "goes from root_path to bars index" do
    visit root_path
    click_link "Bars"
    current_path.should eq(bars_path)
  end
  
  it "views a bar page" do
    bar = FactoryGirl.create(:bar)
    
    visit bar_path(bar)
    page.should have_content bar.name
    page.should have_content bar.address
    page.should have_content bar.zip
    page.should have_content bar.state
    page.should have_content bar.city
    page.should have_link "Website", :href => bar.url
  end
  
  it "requires login before creating" do
    visit root_path
    click_link "Login"
    current_path.should eq(new_user_session_path)
  end

  it "adds a new bar" do
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit bars_path
    click_link "New Bar"
    fill_in "bar_name", :with => "bar name"
    fill_in "bar_address", :with => "bar addy"
    fill_in "bar_zip", :with => "30316"
    fill_in "bar_city", :with => "atl"
    fill_in "bar_state", :with => "GA"
    fill_in "bar_url", :with => "http://www.bar-stop.com/"
    click_button "Create Bar"
    
    current_path.should eq(bars_path)
    page.should have_content "Bar was successfully created."
  end

  it "attempts to add a bar already in the database" do
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit bars_path
    bar = FactoryGirl.create(:bar)
    click_link "New Bar"
    fill_in "bar_name", :with => bar.name
    fill_in "bar_address", :with => bar.address
    fill_in "bar_zip", :with => bar.zip
    fill_in "bar_city", :with => bar.city
    fill_in "bar_state", :with => bar.state
    fill_in "bar_url", :with => bar.url
    click_button "Create Bar"
    
    page.should have_content "Name has already been taken"
  end
  
  it " attempts to create a bar with an invalid zip" do
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_bar_path
    bar = FactoryGirl.create(:bar)
    fill_in "bar_name", :with => bar.name
    fill_in "bar_address", :with => bar.address
    fill_in "bar_zip", :with => "crapy"   # length 5, but not numbers
    fill_in "bar_city", :with => bar.city
    fill_in "bar_state", :with => bar.state
    fill_in "bar_url", :with => bar.url
    click_button "Create Bar"

    current_path.should eq(bars_path)
    page.should have_content "Zip is invalid"
  end

  it " attempts to create a bar with an invalud state" do
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_bar_path
    bar = FactoryGirl.create(:bar)
    fill_in "bar_name", :with => bar.name
    fill_in "bar_address", :with => bar.address
    fill_in "bar_zip", :with => bar.zip
    fill_in "bar_city", :with => "crap"
    fill_in "bar_state", :with => bar.state
    fill_in "bar_url", :with => bar.url
    click_button "Create Bar"
  end
  
  it " attempts to create a bar with an invalid url" do
    user = FactoryGirl.create(:user)
    bar = FactoryGirl.create(:bar)
    
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit new_bar_path
    fill_in "bar_name", :with => bar.name
    fill_in "bar_address", :with => bar.address
    fill_in "bar_zip", :with => bar.zip
    fill_in "bar_city", :with => bar.city
    fill_in "bar_state", :with => bar.state
    fill_in "bar_url", :with => "wwww.nota url"
    click_button "Create Bar"
    current_path.should eq(bars_path)
    page.should have_content "Url is invalid"
  end
  
  it " sorts listings by price" do
    bar = FactoryGirl.create(:bar)
    visit bar_path(bar)
    click_link "Price"
    current_path.should eq(bar_path(bar))
  end
  
  it " sorts listings by abd" do
    bar = FactoryGirl.create(:bar)
    visit bar_path(bar)
    click_link "ABD"
    current_path.should eq(bar_path(bar))
  end
end
