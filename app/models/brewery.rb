require 'uri'

class Brewery < ActiveRecord::Base
	validates_presence_of :name
  validates_format_of :zip, :with => /\A\d{5}([\-]\d{4})?\Z/, :allow_blank => true
	validates_format_of :state, :with => /\A(?-i:A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])\Z/, :message => "should be in the abbreviated form (i.e. GA or CO)", :allow_blank => true
	validates_uniqueness_of :name, :scope => [:address, :zip, :city, :state]
	validates_format_of :url, :with => URI.regexp, :allow_blank => true
	
	has_paper_trail
	
	has_many :beers
	# has_many :beer_items, :through => :beers
	
	def citystate
		return false unless (city != nil && state != nil)
		"#{city} #{state}"
	end
end
