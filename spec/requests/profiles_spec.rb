require 'spec_helper'

describe "Profiles" do
  before(:all) do
    visit root_path
    click_link "Login"
    user = FactoryGirl.create(:user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
  end
  
  it "goes to a user profile" do
    visit root_path
    click_link "Profile"
    current_path.should eq(user_profile_path)
  end
end