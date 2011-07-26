class CreateBreweries < ActiveRecord::Migration
  def self.up
    create_table :breweries do |t|
      t.string :name
      t.string :address
      t.integer :zip
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :breweries
  end
end
