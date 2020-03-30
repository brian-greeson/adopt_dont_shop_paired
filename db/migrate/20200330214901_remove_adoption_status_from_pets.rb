class RemoveAdoptionStatusFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :adoption_status, :string
  end
end
