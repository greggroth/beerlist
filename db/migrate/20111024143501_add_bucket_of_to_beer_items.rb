class AddBucketOfToBeerItems < ActiveRecord::Migration
  def change
    add_column :beer_items, :bucket_of, :integer
  end
end
