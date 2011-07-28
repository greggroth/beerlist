class AddVolumeToBeers < ActiveRecord::Migration
  def self.up
	add_column :beers, :volunit, :string, :default => "oz"

  end

  def self.down
	remove_column :beers, :volunit
  end
end
