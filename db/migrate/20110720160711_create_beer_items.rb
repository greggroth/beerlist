class CreateBeerItems < ActiveRecord::Migration
  def self.up
    create_table :beer_items do |t|

      t.decimal :price
      t.timestamps
    end
  end

  def self.down
    drop_table :beer_items
  end
end
