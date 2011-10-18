class CreateBeerTracks < ActiveRecord::Migration
  def change
    create_table :beer_tracks do |t|
      t.integer :user_id
      t.integer :beer_id
      t.integer :bar_id
      t.integer :rating
      t.string :comment
      t.timestamps
    end
  end
end
