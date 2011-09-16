class Beer < ActiveRecord::Base
	validates_presence_of :name, :brewery_id
	validates_uniqueness_of :name, :scope => :brewery_id, :message => " has already been added for this brewery"

  belongs_to :brewery
	belongs_to :beer_style
	has_many :beer_items, :dependent => :destroy
	has_many :bars, :through => :beer_items
  
  has_paper_trail

  include Tanker
  
  tankit 'index' do
    indexes :name
    indexes :style
    
    # # you may also dynamically retrieve field data
    # indexes :beer_styles do
    #   beer_style.map {|s| s.name }
    # end
  end
  
  
  def style
    if self.try(:beer_style)
      self.beer_style.name
    else
      "n/a"
    end
  end
  
  
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes
  
end
