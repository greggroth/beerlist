class AddPriceToBarsBeers < ActiveRecord::Migration
  def self.up
    add_column :bars_beers, :price, :decimal
  end

  def self.down
    remove_column :bars_beers, :price
  end
end
