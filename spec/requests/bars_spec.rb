require 'spec_helper'

describe "Bars" do
  it "goes from root_path to bars index" do
    visit root_path
    click_link "Bars"
    current_path.should eq(bars_path)
  end
  
  it "adds a new bar" do
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
    click_button "Create Bar"
    page.should have_content "Bar was successfully created."
  end  
end
