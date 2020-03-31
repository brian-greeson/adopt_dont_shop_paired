class ChangeColumnStatusInApplicationPet < ActiveRecord::Migration[5.1]
  def change
    change_column :application_pets, :status, :string, default: "open"
  end
end
