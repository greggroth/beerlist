class AddIdIndexToBeers < ActiveRecord::Migration
  def change
    add_index :beers, :id
  end
end
