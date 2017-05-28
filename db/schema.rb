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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170528195702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "v_interest_points", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.string "name", limit: 254
    t.string "description", limit: 254
    t.string "type", limit: 254
    t.geometry "geom", limit: {:srid=>4326, :type=>"st_point", :has_z=>true, :has_m=>true}
    t.index ["geom"], name: "v_interest_points_geom_idx", using: :gist
  end

  create_table "v_routes", primary_key: "gid", id: :serial, force: :cascade do |t|
    t.string "name", limit: 254
    t.string "descriptio", limit: 254
    t.geometry "geom", limit: {:srid=>4326, :type=>"multi_line_string", :has_z=>true, :has_m=>true}
    t.index ["geom"], name: "v_routes_geom_idx", using: :gist
  end

end
