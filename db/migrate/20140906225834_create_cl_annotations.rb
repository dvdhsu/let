class CreateClAnnotations < ActiveRecord::Migration
  def change
    create_table :cl_annotations do |t|
      t.integer :num_bed
      t.integer :num_bath
      t.integer :size
      t.string :avail
      t.references :cl_property, index: true

      t.timestamps null: false
    end
  end
end
