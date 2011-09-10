class Beer < ActiveRecord::Base
	validates_presence_of :name
	validates_uniqueness_of :name, :scope => :brewery_id, :message => " has already been added for this brewery"

  has_paper_trail

	belongs_to :brewery
	belongs_to :beer_style
	has_many :beer_items, :dependent => :destroy
	has_many :bars, :through => :beer_items
  
end
