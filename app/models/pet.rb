class Pet < ApplicationRecord
  validates_presence_of :name, :image, :approximate_age, :sex, :shelter_id
  belongs_to :shelter
  has_many :application_pets
  has_many :pet_applications, through: :application_pets
end
