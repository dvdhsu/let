class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :source
      t.float :latitude
      t.float :longitude
      t.string :street
      t.string :city
      t.integer :zipcode
      t.string :state
      t.string :country
      t.integer :num_bed
      t.float :num_bath
      t.integer :size
      t.date :avail
      t.string :external_url
      t.string :title
      t.string :body
      t.integer :price
      t.time :expires

      t.timestamps null: false
    end
    add_index :properties, :latitude
    add_index :properties, :longitude
  end
end
