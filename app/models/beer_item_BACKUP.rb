class BeerItem < ActiveRecord::Base
	validates :beer_id, :presence => true
	validates :bar_id, :presence => true
	validates :beer_id, :uniqueness => {:scope => :bar_id}

	belongs_to :bar
	belongs_to :beer
end
