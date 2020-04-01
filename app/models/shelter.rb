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

  def average_rating
    return 0.0 if shelter_reviews.empty?
    shelter_reviews.average(:rating)
  end
end
