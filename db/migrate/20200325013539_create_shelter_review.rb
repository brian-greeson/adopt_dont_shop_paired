class CreateShelterReview < ActiveRecord::Migration[5.1]
  def change
    create_table :shelter_reviews do |t|
      t.string :title
      t.string :content
      t.string :image
      t.integer :rating
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
