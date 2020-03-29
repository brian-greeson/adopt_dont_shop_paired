require "rails_helper"

RSpec.describe PetApplication do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :phone_number}
    it {should validate_presence_of :description}
    it {should validate_presence_of :pet_ids}
    end

    describe "relationships" do
    it {should have_many(:pets).through(:application_pets)}
    end

  describe "class methods" do
    it ".pets" do
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
      application_1 = PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_1.id]
      )

      application_2 = PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_2.id, pet_1.id]
      )

      expect(PetApplication.pets).to eq([pet_1, pet_2])
    end
  end
end
