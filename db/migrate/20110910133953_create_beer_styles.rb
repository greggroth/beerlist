class CreateBeerStyles < ActiveRecord::Migration
  def change
    create_table :beer_styles do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
