class RecreateBeerTracksTable < ActiveRecord::Migration
  def up
    drop_table :beer_tracks
    create_table :beer_tracks do |t|
      t.integer :user_id
      t.integer :beer_id
      t.integer :bar_id
      t.timestamps
    end
  end

  def down
    drop_table :beer_tracks
  end
end
