class BeerStyle < ActiveRecord::Base
  has_many :beers
  
  validates_uniqueness_of :name
end
