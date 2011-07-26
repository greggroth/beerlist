class RemovebarBeerjointable < ActiveRecord::Migration
  def self.up
	begin drop_table "bars_beers" rescue true end
  end

  def self.down
  end
end
