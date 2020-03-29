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

  def self.for_pet(pet_id)
    applications_for_pet = []
    pet_id_integer = pet_id.to_i
    find_each do |application|
      if application.pet_ids.include?(pet_id_integer)
        applications_for_pet << application
      end
    end
    applications_for_pet
  end

end
