class AddUserAndBarIdToBarFollowing < ActiveRecord::Migration
  def self.up
	add_column :bar_followings, :user_id, :integer
	add_column :bar_followings, :bar_id, :integer
  end

  def self.down
	drop_column :bar_followings, :user_id
	drop_column :bar_followings, :bar_id
  end
end
