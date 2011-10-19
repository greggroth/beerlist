class Rating < ActiveRecord::Base
  attr_accessible :value, :dimension

  belongs_to :user
  belongs_to :beer
end
