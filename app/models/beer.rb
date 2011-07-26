class Beer < ActiveRecord::Base
	validates :name, :presence => true

	belongs_to :brewery
	has_many :beer_items
	has_many :bars, :through => :beer_items

end
