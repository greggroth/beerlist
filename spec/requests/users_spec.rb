require 'spec_helper'
require 'beer_item'

describe User do
  it "create a new user" do
    visit root_path
    click_link "Signup"
    fill_in "Email", :with => 'new_user@test.com'
    fill_in "Password", :with => '1234'
    fill_in "Password confirmation", :with => '1234'
    click_button "Signup"
    current_path.should eq(root_path)
    page.should have_content("New user successfully added.")
  end
  
  it "logs in and logs out" do
    user = FactoryGirl.create(:user)
    
    visit root_path
    click_link "Login"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Login"
    current_path.should eq(root_path)
    page.should have_content("Logged in successfully")
    
    click_link "Logout"
    current_path.should eq(root_path)
  end
end
