class AddColumnToBeerTracks < ActiveRecord::Migration
  def change
    add_column :beer_tracks, :beer_item_id, :integer
  end
end
