class Bar < ActiveRecord::Base

	has_many :beer_items
	has_many :beers, :through => :beer_items
end
