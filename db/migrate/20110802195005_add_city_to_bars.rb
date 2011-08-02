class AddCityToBars < ActiveRecord::Migration
  def self.up
	add_column :bars, :city, :string
  end

  def self.down
  	remove_column :bars, :city
  end
end
