class CreateDatabaseStructure < ActiveRecord::Migration[5.1]
  def change
    ActiveRecord::Schema.define(version: 0) do

      # These are extensions that must be enabled in order to support this database
      enable_extension "plpgsql"
      enable_extension "postgis"
      enable_extension "postgis_topology"

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
  end
end
