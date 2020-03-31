require "rails_helper"

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :state}
    it {should validate_presence_of :city}
    it {should validate_presence_of :zip}
  end
  describe "relationships" do
    it {should have_many :pets}
  end

  describe "instance methods" do
    it ".has_pending_pet?" do
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

      app_1 = PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_1.id]
      )

      expect(shelter_1.has_pending_pet?).to eq(false)

      app_to_pet_1 = ApplicationPet.find_by(pet_id: pet_1.id)
      app_to_pet_1.approve

      expect(shelter_1.has_pending_pet?).to eq(true)
    end
  end
end
