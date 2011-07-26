class AddAbvToBeers < ActiveRecord::Migration
  def self.up
	add_column :beers, :abv, :decimal
	add_column :beers, :volume, :decimal
  end

  def self.down
	remove_column :beers, :abv
	remove_column :beers, :volume
  end
end
