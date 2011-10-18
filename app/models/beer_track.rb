class BeerTrack < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer
  belongs_to :bar
end
