class AddWeekdayToBeerItems < ActiveRecord::Migration
  def change
    add_column :beer_items, :weekday, :integer
  end
end
