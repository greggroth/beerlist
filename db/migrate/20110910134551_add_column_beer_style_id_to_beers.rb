class AddColumnBeerStyleIdToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :beer_style_id, :integer
  end
end
