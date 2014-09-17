class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips do |t|
      t.integer :zipcode
      t.string :city
      t.string :county
      t.string :state
      t.string :lat
      t.string :long

      t.timestamps null: false
    end
    add_index :zips, :zipcode
  end
end
