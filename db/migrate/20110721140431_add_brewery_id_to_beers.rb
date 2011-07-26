class AddBreweryIdToBeers < ActiveRecord::Migration
  def self.up
	add_column :beers, :brewery_id, :integer
  end

  def self.down
  end
end
