class CreateClProperties < ActiveRecord::Migration
  def change
    create_table :cl_properties do |t|
      t.string :external_id
      t.string :external_url
      t.string :heading
      t.string :body
      t.string :rent
      t.string :status

      t.integer :external_timestamp
      t.integer :expires

      t.boolean :deleted

      t.timestamps null: false
    end

    add_index :cl_properties, :external_id
    add_index :cl_properties, :external_url
  end
end
