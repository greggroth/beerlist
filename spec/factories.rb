FactoryGirl.define do
  factory :user do
    pw = Forgery::Basic.password
    sequence (:email){ |n| "user_#{n}@atlbeerlist.com" }
    password pw
    password_confirmation pw
  end
  
  factory :bar do
    sequence (:name){ |n| "bar_#{n}" }
    sequence (:address) { |n| "#{n}123 Running Ln"}
    zip {Forgery::Address.zip}
    state {Forgery::Address.state_abbrev}
    city {Forgery::Address.city}
    url "http://www.test.com/"
  end
  
  factory :beer do
    sequence (:name){ |n| "beer_#{n}" }
    abv {Forgery::Basic.number}
    association :brewery
    association :beer_style
  end
  
  factory :brewery do
    sequence (:name){ |n| "brewery_#{n}" }
    address {Forgery::Address.street_address}
    zip {Forgery::Address.zip}
    state {Forgery::Address.state_abbrev}
    city {Forgery::Address.city}
    url "http://www.test.com/"
  end
  
  factory :beer_style do
    sequence (:name){ |n| "style_#{n}" }
    description "test description"
  end

  factory :beer_item do
    association :beer
    association :bar
    association :user
    price {Forgery::Monetary.money}
    volume {Forgery::Basic.number}
    volunit 'oz'
    pouring 'draught'
  end
end
