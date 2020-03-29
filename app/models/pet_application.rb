class PetApplication < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description, :pet_ids
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.pets
    pets_with_applicatons = []
    all.each do |application|
      pets_with_applicatons << application.pets
    end
    pets_with_applicatons.flatten.uniq
  end
end
