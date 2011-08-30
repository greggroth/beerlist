FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "1234"
  end
  
  factory :bar do
    sequence(:name)  { |n| "bar#{n}" }
    address "1234 Flat Shoals Avenue Southeast"
    zip "30316"
    state "GA"
    city "Atlanta"
  end
  
  factory :beer do
    sequence(:name) { |n| "beer#{n}" }
    abv '5'
    brewery_id '1'
  end
  
  factory :beer_item do
    beer_id '1'
    bar_id '1'
    user_id '1'
    price '4.00'
    volume '12'
  end
  
  factory :brewery do
    sequence(:name) { |n| "brewery#{n}" }
    address "1234 Flat Shoals Avenue Southeast"
    zip "30316"
    state "GA"
    city "Atlanta"
  end
end
