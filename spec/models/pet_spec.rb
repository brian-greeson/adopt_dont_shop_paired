require "rails_helper"

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :approximate_age}
    it {should validate_presence_of :shelter_id}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

  describe "instance methods" do
    it ".adoption_status" do
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
      PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_1.id]
      )
      app_2 = PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_1.id, pet_2.id]
      )
      app_to_pet_1 = app_2.application_pets.find_by("pet_id = ?", pet_1.id)

      expect(pet_1.adoption_status).to eq("adoptable")
      expect(pet_2.adoption_status).to eq("adoptable")

      app_to_pet_1.approve

      expect(pet_1.adoption_status).to eq("pending")
      expect(pet_2.adoption_status).to eq("adoptable")
    end

    it ".approved_application" do
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
      PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_1.id]
      )
      app_2 = PetApplication.create(
        name: 'Steve',
        address: '123 Main St',
        city: 'Lakewood',
        state: 'CO',
        zip: '80214',
        phone_number: '9705675555',
        description: 'I like dogs and will take great care of it.',
        pet_ids: [pet_1.id, pet_2.id]
      )

      expect(pet_1.approved_application).to eq(false)

      app_to_pet_1 = app_2.application_pets.find_by("pet_id = ?", pet_1.id)
      app_to_pet_1.approve

      expect(pet_1.approved_application).to eq(app_2)
    end
  end

end
