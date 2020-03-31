class ChangeColumnStatusInApplicationPets < ActiveRecord::Migration[5.1]
  def change
    change_column :application_pets, :status, :string, default: "adoptable"
  end
end
