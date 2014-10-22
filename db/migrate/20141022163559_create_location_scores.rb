class CreateLocationScores < ActiveRecord::Migration
  def change
    create_table :location_scores do |t|
      t.references :ClLocation, index: true
      t.float :score
      t.string :category

      t.timestamps null: false
    end
  end
end
