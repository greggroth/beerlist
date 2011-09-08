require 'spec_helper'

describe "User", :type => :model do
  it "creates a new user" do
    user = User.new
    user.email = "george@gmail.com"
    user.password = "123456"
    assert user.save
  end
end