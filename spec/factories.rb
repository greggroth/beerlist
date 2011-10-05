FactoryGirl.define do
  factory :user do
    pw = Forgery::Basic.password
    email Forgery::Internet.email_address
    password pw
    password_confirmation pw
  end
  
  factory :bar do
    name Forgery::Name.company_name
    address Forgery::Address.street_address
    zip Forgery::Address.zip
    state Forgery::Address.state_abbrev
    city Forgery::Address.city
    url "http://www.test.com/"
  end
  
  factory :beer do
    name Forgery::Name.company_name
    abv Forgery::Basic.number
    brewery_id '1'
  end
  
  factory :brewery do
    name Forgery::Name.company_name
    address Forgery::Address.street_address
    zip Forgery::Address.zip
    state Forgery::Address.state_abbrev
    city Forgery::Address.city
    url "http://www.test.com/"
  end
  
  factory :beer_style do
    name Forgery::Name.company_name
    description "test description"
  end

  factory :beer_item do
    # beer_id '1'
    # bar_id '1'
    # user_id '1'
    price Forgery::Monetary.money
    volume Forgery::Basic.number
    volunit 'oz'
    pouring 'draught'
  end
end
