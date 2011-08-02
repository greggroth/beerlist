class Brewery < ActiveRecord::Base
	validates_presence_of :name
	validates_length_of :zip, :is => 5, :allow_blank => true
	validates_length_of :state, :is => 2, :message => "should be in the abbreviated form (i.e. GA or CO)", :allow_blank => true
	validates_uniqueness_of :name
	
	has_many :beers
	# has_many :beer_items, :through => :beers
	
	def citystate
		return false unless (city != nil && state != nil)
		"#{city} #{state}"
	end
end
