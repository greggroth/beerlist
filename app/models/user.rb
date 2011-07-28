require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	
	validates :email, :uniqueness => true,
			  :length => { :within => 5..50 },
			  :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
	validates :password, :confirmation => true,
			     :length => { :within => 4..20 },
			     :presence => true,
			     :if => :password_required?

	has_one :profile
	has_many :beer_items 
    #, :order => 'beer.name ASC'
	# has_many :bar_permissions
	# has_many :bars, :through => :bar_permissions
	has_many :bar_followings
	has_many :bars, :through => :bar_followings

	before_save :encrypt_new_password

	# def followed_bars
	#  @followed_bars ||=BarFollowing.find_by_user_id(self.id)
	# end

	def is_following?(bar)
		bars.exists?(bar)
	end

	def admin_bars
	   @admin_bars ||=BarPermission.find_by_user_id(self.id)
	end

	def self.authenticate(email, password)
	  user = find_by_email(email)
	  return user if user && user.authenticated?(password)
	end

	def authenticated?(password)
	  self.hashed_password == encrypt(password)
	end

	protected
	  def encrypt_new_password
		return if password.blank?
		self.hashed_password = encrypt(password)
	  end

	  def password_required?
		hashed_password.blank? || password.present?
	  end

	  def encrypt(string)
		Digest::SHA1.hexdigest(string)
	  end
end
