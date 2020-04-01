require 'rails_helper'
RSpec.describe "As a visitor" do
  it "when I vist a pet's show page there is a link to see all applications for this pet" do
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
    visit "/pets/#{pet_1.id}"

    click_link "View Applications"
    expect(current_path).to eq("/pets/#{pet_1.id}/applications")

    expect(page).to have_link(app_1.name)
    expect(page).to have_link(app_2.name)

    click_link "#{app_1.name}"
    expect(current_path).to eq("/pet_applications/#{app_1.id}")
  end

  it "I see a message on the application page indicating there are no applications if so" do
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
    visit "/pets/#{pet_1.id}/applications"
    
    expect(page).to have_content("There are no applications for this pet.")
  end
end
