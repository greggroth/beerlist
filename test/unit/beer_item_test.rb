require 'test_helper'

class BeerItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should create beer_item" do
	beeritem = BeerItem.new

	beeritem.user = users(:eugene)
	beeritem.beer = beers(:bells_oberon)
	beeritem.bar = bars(:the_earl)
	beeritem.price = 5

	assert beeritem.save
   end
	
   test "should find beer_item" do
   	beer_item_id = beer_items(:oberon_at_midway).id
   	assert_nothing_raised { BeerItem.find(beer_item_id) }
   end
   
   test "should update beer_item" do
   	beer_item = beer_items(:oberon_at_midway)
   	assert beer_item.update_attributes(:price => 6.00)
   end
   
   test "should destroy beer_item" do
   	beer_item = beer_items(:oberon_at_midway)
   	beer_item.destroy
   	assert_raise(ActiveRecord::RecordNotFound) { BeerItem.find(beer_item.id) }
   end
   
   test "should not create beer_item without bar_id, beer_id or price" do
   	beer_item = BeerItem.new
   	assert !beer_item.valid?
   	assert beer_item.errors[:beer_id].any?
   	assert beer_item.errors[:bar_id].any?
   	assert beer_item.errors[:price].any?
   	assert_equal ["can't be blank","can't be blank"], beer_item.errors[:beer_id]
   	assert_equal ["can't be blank"], beer_item.errors[:bar_id]
   	assert_equal ["can't be blank"], beer_item.errors[:price]
   	assert !beer_item.save
   end
end
