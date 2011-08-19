class AddFeaturedToBeerItems < ActiveRecord::Migration
  def self.up
    add_column :beer_items, :featured, :boolean
  end

  def self.down
    remove_column :beer_items, :featured
  end
end
