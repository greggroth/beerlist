class BeerItem < ActiveRecord::Base
	validates :beer_id, :presence => true
	validates :bar_id, :presence => true
	validates :beer_id, :uniqueness => {:scope => :bar_id}

	belongs_to :bar
	belongs_to :beer
	belongs_to :user

	after_create :notify_item_create_sucess

	scope :published, where("beer_items.created_at IS NOT NULL")
	scope :recent, lambda { published.where("beer_items.created_at > ?", 1.week.ago.to_date) }
	# scope :where_beer, lambda { |term| where("beers.name LIKE ?", "%#{term}%") }

	def owned_by?(owner)
	  return false unless owner.is_a? User
	  user == owner
	end
 
	def notify_item_create_sucess
	  puts "New beer listing added successfully"
    end

end
