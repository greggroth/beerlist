class AddColumnVolumeToBeerItems < ActiveRecord::Migration
  def self.up
    add_column :beer_items, :volume, :string
  	add_column :beer_items, :volunit, :string, :default => "oz"
  	add_column :beer_items, :pouring, :string
  end

  def self.down
  	remove_column :beer_items, :volume
  	remove_column :beer_items, :volunit
  	remove_column :beer_items, :pouring
  end
end
