class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :destroy

  def has_pending_pet?
    binding.pry
    pets.include?(approved_application)

  end
end
