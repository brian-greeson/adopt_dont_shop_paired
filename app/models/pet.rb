class Pet < ApplicationRecord
  validates_presence_of :name, :image, :approximate_age, :sex, :shelter_id
  belongs_to :shelter
end
