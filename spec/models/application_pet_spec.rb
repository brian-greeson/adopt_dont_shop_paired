require 'rails_helper'

RSpec.describe ApplicationPet do
  describe "relationships" do
    it {should belong_to :pet_application}
    it {should belong_to :pet}
  end

  describe "instance method" do
    it ".approve" do
      shelter_1 = Shelter.create(
        name: "Denver Animal Shelter",
        address: "1241 W Bayaud Ave",
        city: "Denver",
        state: "CO", zip: "80223"
      )
      pet_1 = shelter_1.pets.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
        name: "Spot",
        approximate_age: "5",
        sex: "male"
      )
      pet_2 = shelter_1.pets.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_2.jpg",
        name: "Spike",
        approximate_age: "3",
        sex: "male"
      )
      app_1 = PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_1.id, pet_2.id]
      )
      app_to_pet_1 = ApplicationPet.find_by(pet_id: pet_1.id)
      app_to_pet_2 = ApplicationPet.find_by(pet_id: pet_2.id)

      expect(app_to_pet_1.status).to eq("open")
      expect(app_to_pet_2.status).to eq("open")

      app_to_pet_1.approve

      expect(app_to_pet_1.status).to eq("approved")
      expect(app_to_pet_2.status).to eq("open")
    end
  end
end
