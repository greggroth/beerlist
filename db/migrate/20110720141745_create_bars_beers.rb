class CreateBarsBeers < ActiveRecord::Migration
  def self.up
	create_table :bars_beers, :id => false do |t|
	  t.references :bar
	  t.references :beer
	end
  end

  def self.down
	drop_table :bars_beers
  end
end
