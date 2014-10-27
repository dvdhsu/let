# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141022164243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anchors", force: true do |t|
    t.string   "anchor"
    t.integer  "num_polled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cl_annotations", force: true do |t|
    t.integer  "num_bed"
    t.integer  "num_bath"
    t.integer  "size"
    t.date     "avail"
    t.integer  "cl_property_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "cl_annotations", ["cl_property_id"], name: "index_cl_annotations_on_cl_property_id", using: :btree

  create_table "cl_images", force: true do |t|
    t.string   "href"
    t.integer  "cl_property_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "cl_images", ["cl_property_id"], name: "index_cl_images_on_cl_property_id", using: :btree

  create_table "cl_locations", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country"
    t.string   "state"
    t.string   "metro"
    t.string   "county"
    t.string   "region"
    t.string   "city"
    t.string   "locality"
    t.string   "formatted_address"
    t.string   "geocoded_address"
    t.string   "geolocation_status"
    t.integer  "zipcode"
    t.integer  "accuracy"
    t.integer  "cl_property_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "cl_locations", ["cl_property_id"], name: "index_cl_locations_on_cl_property_id", using: :btree

  create_table "cl_properties", force: true do |t|
    t.string   "external_id"
    t.string   "external_url"
    t.string   "heading"
    t.string   "body"
    t.string   "rent"
    t.integer  "external_timestamp"
    t.integer  "expires"
    t.boolean  "deleted"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "cl_properties", ["external_id"], name: "index_cl_properties_on_external_id", using: :btree
  add_index "cl_properties", ["external_url"], name: "index_cl_properties_on_external_url", using: :btree

  create_table "location_scores", force: true do |t|
    t.integer  "cl_location_id"
    t.float    "walk_score"
    t.float    "bike_score"
    t.float    "drive_score"
    t.string   "category"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "location_scores", ["cl_location_id"], name: "index_location_scores_on_cl_location_id", using: :btree

  create_table "location_venues", force: true do |t|
    t.integer  "cl_location_id"
    t.string   "category"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.float    "rating"
    t.string   "name"
    t.string   "source"
    t.string   "external_id"
    t.string   "external_url"
    t.string   "external_image_url"
    t.string   "phone"
    t.integer  "distance"
    t.integer  "walk_time"
    t.integer  "bike_time"
    t.integer  "drive_time"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "location_venues", ["cl_location_id"], name: "index_location_venues_on_cl_location_id", using: :btree
  add_index "location_venues", ["external_id"], name: "index_location_venues_on_external_id", using: :btree

end
