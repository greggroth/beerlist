class BeerItem < ActiveRecord::Base
	validates_presence_of :beer_id
	validates_presence_of :bar_id
	validates_presence_of :price
	validates_numericality_of :price
	validates_numericality_of :volume
	validates :beer_id, :uniqueness => { :scope => [:bar_id, :volume, :volunit, :pouring], :message => "and bar combination already exists." }

	belongs_to :bar
	belongs_to :beer, :include => [:beer_style, :ratings, :beer_tracks]
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

  def abd
    unless self.beer.abv.nil? || self.volume.nil? || self.price.nil?
      if self.pouring == "bucket"
        case self.volunit
     			when 'oz'
     				(self.beer.abv*self.volume*self.bucket_of)/(100*self.price)
     			when 'ml'
     				(self.beer.abv*self.volume*self.bucket_of*0.03381)/(100*self.price)
     			when 'cl'
     				(self.beer.abv*self.volume*self.bucket_of*0.3381)/(100*self.price)
     		end
      else
   		  case self.volunit
     			when 'oz'
     				(self.beer.abv*self.volume)/(100*self.price)
     			when 'ml'
     				(self.beer.abv*self.volume*0.03381)/(100*self.price)
     			when 'cl'
     				(self.beer.abv*self.volume*0.3381)/(100*self.price)
     		end
     	end
   	else
   	  return 0
 	  end
  end
    
  def self.top_deals
    all_items = BeerItem.find(:all, :include => [:bar, :beer])
    ordered = all_items.sort_by { |e| -e.abd }            #  put things in order by abd
    beer_id_check = []  #  <-- preallocating:  a hard habit to break after using matlab for so long  
    results = []
    
    i = 0
    
    while results.count <= [20, ordered.count].min   # find the first 20 unique items
      break if ordered.at(i).nil?
      unless beer_id_check.include? ordered.at(i).beer_id  #  if the beer_id hasn't already been used
        results << ordered.at(i)                           #  then add it to the results
        beer_id_check << ordered.at(i).beer_id             #  and keep track of the beer_id to check against
      end
      i += 1
    end
    
    return results
  end
end
