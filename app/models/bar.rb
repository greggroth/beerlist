class Bar < ActiveRecord::Base

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
	  @admins ||=BarPermission.find_all_by_bar_id(self.id)
	end

	def is_followed?(applicant)
	  return false unless applicant.is_a? User
	  users.exists?(:id => applicant.id)
	end

	# def followers
	#  @followers ||=BarFollowing.find_all_by_bar_id(self.id)
	# end

end
