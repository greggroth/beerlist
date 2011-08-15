class AddGmapsToBars < ActiveRecord::Migration
  def self.up
    add_column :bars, :gmaps, :boolean
  end

  def self.down
    remove_column :bars, :gmaps
  end
end
