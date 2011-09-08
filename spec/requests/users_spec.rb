require 'spec_helper'
require 'beer_item'

describe User do
  it "create a new user" do
    visit root_path
    click_link "Signup"
    fill_in "Email", :with => 'new_user@test.com'
    fill_in "Password", :with => '123456'
    fill_in "Password confirmation", :with => '123456'
    click_button "Sign up"
    current_path.should eq(root_path)
    page.should have_content("Welcome! You have signed up successfully.")
  end
  
  it "logs in and logs out" do
    user = FactoryGirl.create(:user)
    
    visit root_path
    click_link "Login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    current_path.should eq(root_path)
    page.should have_content("Signed in successfully.")
    page.should have_content("Welcome, #{user.email}")
    
    click_link "Logout"
    current_path.should eq(root_path)
    page.should have_content("Signed out successfully.")
  end
  
  it " follows a new bar" do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:bar)
    
    visit root_path
    click_link "Login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    
    visit bars_path
    # save_and_open_page
  end
end
