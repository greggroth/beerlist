class Profile < ActiveRecord::Base
	belongs_to :user
	
	attr_accessible :all
	
	validates_uniqueness_of :user_id
end
