class Bar < ActiveRecord::Base

	has_many :bar_permissions
	has_many :users, :through => :bar_permissions
	has_many :beer_items
	has_many :beers, :through => :beer_items

	def has_permission?(owner)
	  return false unless owner.is_a? User
	  users.exists?(owner.id)
	end

end
