class AddIndexToBrewery < ActiveRecord::Migration
  def change
    add_index :breweries, :id
  end
end
