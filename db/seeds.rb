# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

bar1 = Bar.create :name => 'The Earl'
bar2 = Bar.create :name => 'Midway Pub'

beer1 = Beer.create :name => 'Red Bridge'
beer2 = Beer.create :name => 'Blue Mood'
beer3 = Beer.create :name => 'PBR'

user = User.create :email => 'gregg@gregg.com',
		   :password => '1234',
		   :passowrd_confirmation => '1234'

user.beer_items.create :beer_id => beer1.id,
			:bar_id => bar1.id

user.beer_items.create :beer_id => beer2.id,
			:bar_id => bar1.id

user.beer_items.create :beer_id => beer3.id,
			:bar_id => bar2.id

user.beer_items.create :beer_id => beer2.id,
			:bar_id => bar2.id
