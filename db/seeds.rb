# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Bar.create :name => 'The Earl', 
            :address => '123 Oak Ln',
            :city => 'Atlanta', 
            :state => 'GA',
            :zip => '30316'
            
Bar.create :name => 'The Porter Beer Bar'
Bar.create :name => 'Brick Store Pub'
                  

