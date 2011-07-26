class Brewery < ActiveRecord::Base
	has_many :beers
	# has_many :beer_items, :through => :beers
end
