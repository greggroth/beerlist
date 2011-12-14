class AddBarIdAsIndexOnBeerItems < ActiveRecord::Migration
  def up
    add_index :beer_items, :bar_id
    add_index :beer_items, :beer_id
  end

  def down
    remove_index :beer_items, :bar_id
    remove_index :beer_items, :beer_id
  end
end
