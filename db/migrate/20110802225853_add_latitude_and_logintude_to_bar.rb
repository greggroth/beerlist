class AddLatitudeAndLogintudeToBar < ActiveRecord::Migration
  def self.up
    add_column :bars, :latitude, :float
    add_column :bars, :longitude, :float
  end

  def self.down
    remove_column :bars, :longitude
    remove_column :bars, :latitude
  end
end
