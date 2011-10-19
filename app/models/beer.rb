class Beer < ActiveRecord::Base
	validates_presence_of :name, :brewery_id
	validates_numericality_of :abv
	validates_uniqueness_of :name, :scope => :brewery_id, :message => " has already been added for this brewery"

  belongs_to :brewery
	belongs_to :beer_style
	has_many :beer_items, :dependent => :destroy
	has_many :bars, :through => :beer_items
	
	has_many :beer_tracks
	has_many :fans, :through => :beer_tracks, :source => :user
	
	has_many :ratings
	has_many :raters, :through => :ratings, :source => :user
  
  has_paper_trail

  include Tanker
  
  tankit 'index' do
    indexes :name
    indexes :style
    indexes :brewery_name
  end
  
  
  def style
    if self.try(:beer_style)
      self.beer_style.name
    else
      ""
    end
  end
  
  def brewery_name
    if self.brewery.present?
      self.brewery.name
    end
  end
  
  def average_rating(dimension)
    ratings = self.ratings.find(:all, :conditions => ["dimension = ?", dimension])
    ratings.inject(0) { |sum, el| sum + el[:value] }.to_f / ratings.size
  end
  
  
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes
  
end
