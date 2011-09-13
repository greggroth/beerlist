class Beer < ActiveRecord::Base
	validates_presence_of :name
	validates_uniqueness_of :name, :scope => :brewery_id, :message => " has already been added for this brewery"

  has_paper_trail

  include Tanker
  
  tankit 'index' do
    indexes :name
  end
  
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes

	belongs_to :brewery
	belongs_to :beer_style
	has_many :beer_items, :dependent => :destroy
	has_many :bars, :through => :beer_items
  
end
