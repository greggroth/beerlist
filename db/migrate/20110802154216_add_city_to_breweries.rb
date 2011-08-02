class AddCityToBreweries < ActiveRecord::Migration
  def self.up
  	add_column :breweries, :city, :string
  end

  def self.down
    drop_column :breweries, :city
  end
end
