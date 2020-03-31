class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :pet_application

  def approve
    update(status: "approved")
  end

  def revoke
    update(status: "open")
  end

end
