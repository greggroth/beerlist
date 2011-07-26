require 'test_helper'

class BeerItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should create beer_item" do
	beeritem = BeerItem.new

	beeritem.user = users.first
	beeritem.beer = beers.first
	beeritem.bar = bars.first

	assert beeritem.save
  end
end
