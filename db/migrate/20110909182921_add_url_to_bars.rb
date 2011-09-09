class AddUrlToBars < ActiveRecord::Migration
  def change
    add_column :bars, :url, :string
  end
end
