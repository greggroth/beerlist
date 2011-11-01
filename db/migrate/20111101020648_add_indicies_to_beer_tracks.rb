class AddIndiciesToBeerTracks < ActiveRecord::Migration
  def change
    add_index :beer_tracks, :user_id
    add_index :beer_tracks, :beer_id
  end
end
