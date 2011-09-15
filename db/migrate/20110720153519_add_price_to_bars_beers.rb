class AddPriceToBarsBeers < ActiveRecord::Migration
  def self.up
    add_column :beer_items, :price, :decimal
  end

  def self.down
    remove_column :bars_beers, :price
  end
end
