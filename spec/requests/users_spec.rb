require 'spec_helper'
require 'beer_item'

describe User do
  before(:each) do
    User.all.each { |i| i.destroy }
    @user = FactoryGirl.create(:user)
  end
  
  it "create a new user" do
    visit root_path
    click_link "Signup"
    fill_in "Email", :with => 'new_user@test.com'
    fill_in "user_password", :with => '123456'
    fill_in "user_confirm_password", :with => '123456'
    click_button "Sign up"
    current_path.should eq(root_path)
    page.should have_content("Welcome to ATL Beer List!  Check your e-mail to confirm your account")
  end
  
  it "logs in and logs out" do
    visit root_path
    click_link "Login"
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
    current_path.should eq(root_path)
    page.should have_content("Welcome back!")
    page.should have_content("Welcome, #{@user.email}")
    
    click_link "Logout"
    current_path.should eq(root_path)
    page.should have_content("See you later!")
  end
  
  it " attempts login with invalid password" do
    visit root_path
    click_link "Login"
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "1234"
    click_button "Sign in"
    current_path.should eq(new_user_session_path)
    page.should have_content "Invalid email or password."
  end
  
  it " attempts login with invalid e-mail" do
    visit root_path
    click_link "Login"
    fill_in "Email", :with => "invalid@email.com"
    fill_in "Password", :with => "1234567"
    click_button "Sign in"
    current_path.should eq(new_user_session_path)
    page.should have_content "Invalid email or password."
  end
  
  # it " follows a new bar" do       ###  Needs to be finished  ####
  #   FactoryGirl.create(:bar)
  #   
  #   visit root_path
  #   click_link "Login"
  #   fill_in "Email", :with => @user.email
  #   fill_in "Password", :with => @user.password
  #   click_button "Sign in"
  #   
  #   visit bars_path
  #   # save_and_open_page
  # end
end
