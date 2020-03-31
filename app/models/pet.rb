class Pet < ApplicationRecord
  validates_presence_of :name, :image, :approximate_age, :sex, :shelter_id
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :pet_applications, through: :application_pets

  def adoption_status
    if pet_applications.where("status = ?", "approved").exists?
      "pending"
    else
      "adoptable"
    end
  end

  def approved_application
    self.application_pets.where(status: "approved").first.pet_application
  end
end
