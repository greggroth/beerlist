class AddColumnToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :dimension, :string
  end
end
