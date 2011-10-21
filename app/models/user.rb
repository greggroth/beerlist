class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
	# attr_accessor :password

	# has_one :profile, :dependent => :destroy
	has_many :beer_items 
	has_many :bar_permissions, :dependent => :destroy
	has_many :bar_followings, :dependent => :destroy
	has_many :bars, :through => :bar_followings
	
	has_many :beer_tracks, :dependent => :destroy
	has_many :had_beers, :through => :beer_tracks, :source => :beer
	
	has_many :ratings
	has_many :rated_beers, :through => :ratings, :source => :beer


	def is_following?(bar)
		bars.exists?(bar)
	end

	def follow!(bar)
		self.bars << bar
	end

	def unfollow!(bar)
		self.bar_followings.find_by_bar_id(bar).destroy
	end
	
	def has_drunk?(beer)
	  self.had_beers.exists?(beer)
	end
	
	def drinks_it(beer_track)
	  if beer_track.has_key?(:beer_id)
	    b = self.beer_tracks.new beer_track
	    b.save
	  else
	    return false
	  end
	end
	
	def didnt_drink(beer)
	 self.beer_tracks.find_by_beer_id(beer).destroy
	end

	def admin_bars
	   # ind = BarPermission.find(:all, :conditions => ["user_id=?",self.id], :select=> "bar_id").map(&:bar_id)
	   ind = self.bar_permissions.collect { |t| t.bar_id }
	   @admin_bars = Bar.find(ind).sort_by(&:name)
	end
	
	def is_a_bar_admin?
		not(self.admin_bars.empty?)
	end
end
