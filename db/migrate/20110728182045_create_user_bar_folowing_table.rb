class CreateUserBarFolowingTable < ActiveRecord::Migration
  def self.up
	create_table :bars_users, :id => false do |t|
		t.integer :bar_id
		t.integer :user_id
	end
  end

  def self.down
	deop_table :bars_users
  end
end
