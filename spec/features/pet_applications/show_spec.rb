require 'rails_helper'

RSpec.describe "As a visitor when I visit the application show page" do
  it "I can see the application details" do
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

    visit "/pet_applications/#{app_1.id}"

    within("section.application-#{app_1.id}-details") do
      expect(page).to have_content("Name: #{app_1.name}")
      expect(page).to have_content("Address: #{app_1.address}")
      expect(page).to have_content("City: #{app_1.city}")
      expect(page).to have_content("State: #{app_1.state}")
      expect(page).to have_content("Zip: #{app_1.zip}")
      expect(page).to have_content("Phone Number: #{app_1.phone_number}")
      expect(page).to have_content("Description: #{app_1.description}")
    end

    within("section.application-#{app_1.id}-pets") do
      expect(page).to have_link(pet_1.name)
    end
  end

  it "I can approve the application for each pet on the application" do
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
      sex: "male",
      description: "abc"
    )

    pet_2 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_2.jpg",
      name: "Tops",
      approximate_age: "52",
      sex: "female",
      description: "abc"
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

    app_2 = PetApplication.create(
      name: 'Brian',
      address: '1ew2e Main St',
      city: 'Laksdfood',
      state: 'Cds',
      zip: '802314',
      phone_number: '9702375555',
      description: 'I hate dogs and will take great care of it.',
      pet_ids: [pet_1.id, pet_2.id]
    )

    visit "/pet_applications/#{app_1.id}"

    within "section.application-#{app_1.id}-pets" do
      find("#approve-#{pet_1.id}").click
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("pending")
    expect(page).to have_content("On hold for #{app_1.name}")

    visit "/pet_applications/#{app_1.id}"

    within "section.application-#{app_1.id}-pets" do
      find("#approve-#{pet_2.id}").click
    end

    expect(current_path).to eq("/pets/#{pet_2.id}")
    expect(page).to have_content("pending")
    expect(page).to have_content("On hold for #{app_1.name}")
  end

  it "will not allow me to apply for a pet that already has an approved application" do
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

    app_2 = PetApplication.create(
      name: 'Brian',
      address: '123 Main St',
      city: 'Lakewood',
      state: 'CO',
      zip: '80214',
      phone_number: '9705675555',
      description: 'I like dogs and will take great care of it.',
      pet_ids: [pet_1.id]
    )

    app_to_pet_1 = ApplicationPet.find_by(pet_id: pet_1.id)
    app_to_pet_1.approve
    visit "/pet_applications/#{app_1.id}"

    within "section.application-#{app_1.id}-pets" do
      expect(page).to_not have_css("#approve-#{pet_1.id}")
    end

    visit "/pet_applications/#{app_2.id}"

    within "section.application-#{app_2.id}-pets" do
      expect(page).to_not have_css("#approve-#{pet_1.id}")
    end
  end

  it "I can revoke approved applications" do
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

    app_2 = PetApplication.create(
      name: 'Brian',
      address: '123 Main St',
      city: 'Lakewood',
      state: 'CO',
      zip: '80214',
      phone_number: '9705675555',
      description: 'I like dogs and will take great care of it.',
      pet_ids: [pet_1.id]
    )

    app_to_pet_1 = ApplicationPet.find_by(pet_id: pet_1.id)
    app_to_pet_1.approve
    visit "/pet_applications/#{app_1.id}"

    within "section.application-#{app_1.id}-pets" do
      find("#revoke-#{pet_1.id}").click
    end

    expect(current_path).to eq("/pet_applications/#{app_1.id}")

    within "section.application-#{app_1.id}-pets" do
      expect(page).to have_css("#approve-#{pet_1.id}")
    end

    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("adoptable")
    expect(page).to_not have_content("On hold")
  end
end
