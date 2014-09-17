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

ActiveRecord::Schema.define(version: 20140917052914) do

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
    t.string   "lat"
    t.string   "long"
    t.string   "country"
    t.string   "state"
    t.string   "metro"
    t.string   "county"
    t.string   "region"
    t.string   "city"
    t.string   "locality"
    t.string   "formatted_address"
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

  create_table "zips", force: true do |t|
    t.integer  "zipcode"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "lat"
    t.string   "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "zips", ["zipcode"], name: "index_zips_on_zipcode", using: :btree

end
