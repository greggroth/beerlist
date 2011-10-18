class AddColumnToBeerTracks < ActiveRecord::Migration
  def change
    add_column :beer_tracks, :integer, :beer_item_id
  end
end
