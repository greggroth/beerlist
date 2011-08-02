class Bar < ActiveRecord::Base
	validates_presence_of :name
	validates_length_of :zip, :is => 5
	validates_length_of :state, :is => 2, :message => "should be in the abbreviated form (i.e. GA or CO)"

	# has_many :bar_permissions
	# has_many :users, :through => :bar_permissions
	has_many :beer_items
	has_many :beers, :through => :beer_items
	has_many :bar_followings
	has_many :users, :through => :bar_followings


	def has_permission?(owner)
	  return false unless owner.is_a? User
	  # users.exists?(owner.id)
	  BarPermission.exists?(:user_id => owner.id, :bar_id => self.id)
	end

	def admins
		ind = BarPermission.find(:all, :conditions => (bar_id=self.id), :select=> "user_id").map(&:user_id)
	    @admins ||= User.find(ind)
	end

	def is_followed?(applicant)
	  return false unless applicant.is_a? User
	  users.exists?(:id => applicant.id)
	end

	def followers_email
	  # @followers ||=BarFollowing.find_all_by_bar_id(self.id)
	  @followers ||= self.users.find(:all, :select => "email").map(&:email)
	end

end
