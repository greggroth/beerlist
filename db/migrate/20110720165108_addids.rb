class Addids < ActiveRecord::Migration
  def self.up
	add_column :beer_items, :beer_id, :integer
	add_column :beer_items, :bar_id, :integer

  end

  def self.down
  end
end
