class CreateBarFollowings < ActiveRecord::Migration
  def self.up
    create_table :bar_followings do |t|
		t.integer :user_id
		t.integer :bar_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bar_followings
  end
end
