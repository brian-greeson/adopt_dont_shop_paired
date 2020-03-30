class ChangeadoptionStatusToStringInPets < ActiveRecord::Migration[5.1]
  def change
    change_column :pets, :adoption_status, :string, default: "Adoptable"
  end
end
