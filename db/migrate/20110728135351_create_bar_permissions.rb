class CreateBarPermissions < ActiveRecord::Migration
  def self.up
    create_table :bar_permissions do |t|
		t.integer :user_id
		t.integer :bar_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bar_permissions
  end
end
