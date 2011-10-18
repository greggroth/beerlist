class BeerTrack < ActiveRecord::Base
  validates_presence_of :user_id, :beer_id
  
  belongs_to :user
  belongs_to :beer
  belongs_to :bar
end
