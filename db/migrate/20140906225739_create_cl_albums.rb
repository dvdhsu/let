class CreateClAlbums < ActiveRecord::Migration
  def change
    create_table :cl_albums do |t|
      t.string :full_src
      t.string :thumbnail_src
      t.integer :full_width
      t.integer :full_height
      t.integer :thumbnail_width
      t.integer :thumbnail_height
      t.references :cl_property, index: true

      t.timestamps null: false
    end
  end
end
