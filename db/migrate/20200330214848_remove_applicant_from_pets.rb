class RemoveApplicantFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :applicant, :string
  end
end
