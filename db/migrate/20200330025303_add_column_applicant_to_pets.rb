class AddColumnApplicantToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :applicant, :string
  end
end
