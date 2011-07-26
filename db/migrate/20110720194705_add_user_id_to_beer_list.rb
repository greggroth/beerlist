class AddUserIdToBeerList < ActiveRecord::Migration
  def self.up
    add_column :beer_items, :user_id, :integer
  end

  def self.down
    remove_column :beer_items, :user_id
  end
end
