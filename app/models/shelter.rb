class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :destroy

  def has_pending_pet?
    pets.joins(:application_pets).where('application_pets.status = ?', "approved").exists?
  end

  def pet_count
    pets.count
  end
end
