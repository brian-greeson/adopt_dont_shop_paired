class CreateApplicationPets < ActiveRecord::Migration[5.1]
  def change
    create_table :application_pets do |t|
      t.references :pet, foreign_key: true
      t.references :pet_application, foreign_key: true

      t.timestamps
    end
  end
end
