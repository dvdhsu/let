class CreateAnchors < ActiveRecord::Migration
  def change
    create_table :anchors do |t|
      t.string :anchor
      t.integer :num_polled

      t.timestamps null: false
    end
  end
end
