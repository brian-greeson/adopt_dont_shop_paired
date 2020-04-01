require 'rails_helper'

RSpec.describe "pet page", type: :feature do
  it "can show individual pets with their details" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

    pet_1 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      description: "Jack Russell Terrier with tons of energy!",
      approximate_age: "5",
      sex: "male"
    )

    pet_2 = shelter_1.pets.create(
      image: "https://c8.alamy.com/comp/2A8F42Y/a-young-white-domestic-shorthair-cat-with-blue-eyes-and-a-surprised-expression-2A8F42Y.jpg",
      name: "Sugar",
      description: "White cat with blue eyes. Very sweet and lovable!",
      approximate_age: "3",
      sex: "female"
    )

    visit "/pets/#{pet_1.id}"

    expect(page).to have_css("img[src*= '#{pet_1.image}']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.description)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.adoption_status)

    expect(page).to_not have_css("img[src*= '#{pet_2.image}']")
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_content(pet_2.description)
    expect(page).to_not have_content(pet_2.approximate_age)
    expect(page).to_not have_content(pet_2.sex)
  end

  it "there is a navigation link to shelter index and pet index" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    pet_1 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      description: "Jack Russell Terrier with tons of energy!",
      approximate_age: "5",
      sex: "male"
    )

    visit "/pets/#{pet_1.id}"
    click_on "All Shelters"
    expect(page).to have_current_path "/shelters"

    visit "/pets/#{pet_1.id}"
    click_on "All Pets"
    expect(page).to have_current_path "/pets"
  end

  it "If there is an approved application on a pet, I cannot deletes that pet" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    pet_1 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      description: "Jack Russell Terrier with tons of energy!",
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
    app_to_pet_1 = ApplicationPet.find_by(pet_id: pet_1.id)
    app_to_pet_1.approve

    visit "/pets/#{pet_1.id}"

    expect(page).to_not have_link("Delete")
  end
end
