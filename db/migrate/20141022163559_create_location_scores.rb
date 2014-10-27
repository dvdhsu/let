class CreateLocationScores < ActiveRecord::Migration
  def change
    create_table :location_scores do |t|
      t.references :cl_location, index: true
      t.float :walk_score
      t.float :bike_score
      t.float :drive_score
      t.string :category

      t.timestamps null: false
    end
  end
end
