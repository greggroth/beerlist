require 'uri'

class Bar < ActiveRecord::Base
	validates_presence_of :name, :address, :state, :zip, :city
	validates_uniqueness_of :name, :scope => [:address, :zip, :city, :state]
	
	validates_format_of :state, :with => /\A(?-i:A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])\Z/, :message => "should be in the abbreviated form (i.e. GA or CO)", :allow_blank => true
  validates_format_of :url, :with => URI.regexp, :allow_blank => true
  validates_format_of :zip, :with => /\A\d{5}([\-]\d{4})?\Z/, :allow_blank => true
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  has_paper_trail
  has_attached_file :photo,
    :styles => { :small => "150x150>", :medium => "200x300>" },
    :storage => :s3,
    :bucket => 'barphotos.atlbeerlist.com',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  
  include Tanker
  
  tankit 'index' do
    indexes :name
    indexes :address
    indexes :city
    indexes :state
    indexes :zip
  end
  
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes

	has_many :bar_permissions, :dependent => :destroy
	has_many :beer_items, :dependent => :destroy
	has_many :beers, :through => :beer_items
	has_many :bar_followings, :dependent => :destroy
	has_many :users, :through => :bar_followings

	geocoded_by :full_address
	
	# after_validation :geocode, :if => (:address_changed? || :zip_changed?)
	acts_as_gmappable
	
	def gmaps4rails_address
	  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
	  "#{self.address}, #{self.zip}, #{self.state}" 
	end
	
	def gmaps4rails_infowindow
		"<p><b>#{self.name}</b></p><p>#{self.address}, #{self.zip}  #{self.state}</p><p><a href=#{self.url}>#{self.url}</a></p>"
	end
	
	def gmaps4rails_title
		"#{self.name}"
	end

	def has_permission?(owner)
	  return false unless owner.is_a? User
	  # users.exists?(owner.id)
	  # BarPermission.exists?(:user_id => owner.id, :bar_id => self.id)
	end

	def admins
		# ind = BarPermission.find(:all, :conditions => (bar_id=self.id), :select=> "user_id").map(&:user_id)
	    ind = self.bar_permissions.collect { |t| t.user_id }
	    @admins ||= User.find(ind)
	end

	def is_followed?(applicant)
	  return false unless applicant.is_a? User
	  users.exists?(:id => applicant.id)
	end

	def followers_emails
	  # @followers ||=BarFollowing.find_all_by_bar_id(self.id)
	  # @followers ||= self.users.find(:all, :select => "email").map(&:email)
	  self.users.find(:all, :select => "email").map(&:email)
	end
	
	def recent_followers
	  self.users.find(:all, :conditions => ["bar_followings.created_at > ?", 1.month.ago])
	end
	
	def followers_data
	  followers_histogram_data = Array.new
	  51.times do |n|
	  	followers_histogram_data.push [n.week.ago.strftime("%Y-%m-%d"), self.users.find(:all, :conditions => ["bar_followings.created_at < ?", n.week.ago]).count]
	  end
	  return followers_histogram_data.to_json
	end
	
	def followers_data_csv
	  followers_histogram_data = Array.new
	  51.times do |n|
	  	followers_histogram_data.push [n.week.ago.strftime("%Y-%m-%d"), self.users.find(:all, :conditions => ["bar_followings.created_at < ?", n.week.ago]).count]
	  end
	  return followers_histogram_data.join ','
	end
	
	def full_address
		self.address + ", " + self.zip
	end
	
end
