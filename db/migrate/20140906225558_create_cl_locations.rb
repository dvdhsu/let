class CreateClLocations < ActiveRecord::Migration
  def change
    create_table :cl_locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :country
      t.string :state
      t.string :metro
      t.string :county
      t.string :region
      t.string :city
      t.string :locality
      t.string :formatted_address
      t.string :geocoded_address
      t.string :geolocation_status
      t.integer :zipcode
      t.integer :accuracy
      t.references :cl_property, index: true

      t.timestamps null: false
    end
  end
end
