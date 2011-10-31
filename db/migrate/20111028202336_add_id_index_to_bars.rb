class AddIdIndexToBars < ActiveRecord::Migration
  def change
    add_index :bars, :id
  end
end
