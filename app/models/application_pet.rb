class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :pet_application
end
