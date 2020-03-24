class CreatePet < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image
      t.string :name
      t.string :approximate_age
      t.string :sex
      t.string :description
      t.string :adoption_status, default: "adoptable"
    end
  end
end
