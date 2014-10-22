class CreateLocationVenues < ActiveRecord::Migration
  def change
    create_table :location_venues do |t|
      t.references :cl_location, index: true
      t.string :category
      t.string :address
      t.float :longitude
      t.float :latitude
      t.float :rating
      t.string :name
      t.string :source
      t.string :external_id
      t.string :external_url
      t.string :external_image_url
      t.string :phone
      t.integer :distance
      t.integer :walk_time
      t.integer :bike_time
      t.integer :drive_time

      t.timestamps null: false
    end
    add_index :location_venues, :external_id
  end
end
