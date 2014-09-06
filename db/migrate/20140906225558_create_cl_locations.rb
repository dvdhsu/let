class CreateClLocations < ActiveRecord::Migration
  def change
    create_table :cl_locations do |t|
      t.string :lat
      t.string :long
      t.string :state
      t.string :metro
      t.string :county
      t.string :region
      t.string :city
      t.string :locality
      t.string :formatted_address
      t.integer :zipcode
      t.integer :accuracy
      t.references :cl_property, index: true

      t.timestamps null: false
    end
  end
end
