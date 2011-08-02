class ChangeZipTypeToString < ActiveRecord::Migration
  def self.up
  	change_table :breweries do |b|
  		b.change :zip, :string
  	end
  	
  	change_table :bars do |t|
  		t.change :zip, :string
  	end
  
  end

  def self.down
    change_table :breweries do |b|
  		b.change :zip, :integer
  	end
  	
  	change_table :bars do |t|
  		t.change :zip, :integer
  	end
  end
end
