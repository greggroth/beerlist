class BeerItem < ActiveRecord::Base
	validates_presence_of :beer_id
	validates_presence_of :bar_id
	validates_presence_of :price
	validates :beer_id, :uniqueness => { :scope => [:bar_id, :volume, :volunit, :pouring], :message => "and bar combination already exists." }

	belongs_to :bar
	belongs_to :beer
	belongs_to :user
	belongs_to :brewery
	
	has_paper_trail
	
  # searchable do
  #   text :pouring
  #   end

	# after_create :notify_item_create_sucess

	scope :published, where("beer_items.created_at IS NOT NULL")
	scope :recent, lambda { published.where("beer_items.created_at > ?", 1.week.ago.to_date) }
	# scope :where_beer, lambda { |term| where("beers.name LIKE ?", "%#{term}%") }
	scope :ordered, :order => "price ASC"
	scope :alphabetical, :include => [:beer], :order => "beers.name ASC"

	def owned_by?(owner)
	  return false unless owner.is_a? User
	  user == owner
	end
 
	def notify_item_create_sucess
	  puts "New beer listing added successfully"
  end

	def breweryid
	  beer.brewery.id
	end
	
	def beer_name
	  self.beer.name
  end
  
  def bar_name
    bar.name
  end


end
