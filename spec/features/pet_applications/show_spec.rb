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
end
