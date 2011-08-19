# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110819175240) do

  create_table "bar_followings", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.integer   "bar_id"
  end

  create_table "bar_permissions", :force => true do |t|
    t.integer   "user_id"
    t.integer   "bar_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "bars", :force => true do |t|
    t.string    "name"
    t.string    "address"
    t.string    "zip"
    t.string    "state"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "city"
    t.float     "latitude"
    t.float     "longitude"
    t.boolean   "gmaps"
  end

  create_table "bars_users", :id => false, :force => true do |t|
    t.integer "bar_id"
    t.integer "user_id"
  end

  create_table "beer_items", :force => true do |t|
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "beer_id"
    t.integer  "bar_id"
    t.integer  "user_id"
    t.decimal  "volume"
    t.string   "volunit",    :default => "oz"
    t.string   "pouring"
    t.boolean  "featured"
  end

  create_table "beers", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "brewery_id"
    t.decimal   "abv"
    t.decimal   "volume"
    t.string    "volunit",     :default => "oz"
  end

  create_table "breweries", :force => true do |t|
    t.string    "name"
    t.string    "address"
    t.string    "zip"
    t.string    "state"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "city"
  end

  create_table "profiles", :force => true do |t|
    t.integer   "user_id"
    t.string    "name"
    t.date      "birthday"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string    "session_id", :null => false
    t.text      "data"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "hashed_password"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
