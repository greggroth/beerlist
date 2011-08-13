class ChangeVolumeTypeToString < ActiveRecord::Migration
  def self.up
	change_column :beer_items, :volume, :decimal	
  end

  def self.down
  end
end
