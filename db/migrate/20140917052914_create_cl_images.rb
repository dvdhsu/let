class CreateClImages < ActiveRecord::Migration
  def change
    create_table :cl_images do |t|
      t.string :href
      t.references :cl_property, index: true

      t.timestamps null: false
    end
  end
end
