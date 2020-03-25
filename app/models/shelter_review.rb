class ShelterReview < ApplicationRecord
  validates_presence_of :title, :rating, :content, :shelter_id
  belongs_to :shelter
end
