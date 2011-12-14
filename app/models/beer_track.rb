class BeerTrack < ActiveRecord::Base
  validates_presence_of :user_id, :beer_id
  validates_uniqueness_of :user_id, scope: :beer_id
  
  belongs_to :user
  belongs_to :beer
  belongs_to :bar
end
