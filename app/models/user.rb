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

	has_one :profile, :dependent => :destroy
	has_many :beer_items 
	has_many :bar_permissions, :dependent => :destroy
	has_many :bar_followings, :dependent => :destroy
	has_many :bars, :through => :bar_followings

	before_save :encrypt_new_password

	# def followed_bars
	#  @followed_bars ||=BarFollowing.find_by_user_id(self.id)
	# end

	def is_following?(bar)
		bars.exists?(bar)
	end

	def follow!(bar)
		self.bars << bar
	end

	def unfollow!(bar)
		self.bar_followings.find_by_bar_id(bar).destroy
	end

	def admin_bars
	   # ind = BarPermission.find(:all, :conditions => ["user_id=?",self.id], :select=> "bar_id").map(&:bar_id)
	   ind = self.bar_permissions.collect { |t| t.bar_id }
	   @admin_bars = Bar.find(ind).sort_by(&:name)
	end
	
	def is_a_bar_admin?
		not(self.admin_bars.empty?)
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
