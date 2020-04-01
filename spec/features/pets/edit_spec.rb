require 'rails_helper'

RSpec.describe "As a visitor When I visit the pet show page" do
  it "I can click Update Pet to update a pet" do
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
    click_on 'Update Pet'

    expect(page).to have_current_path "/pets/#{pet_1.id}/edit"

    fill_in :name, with: 'Sport'
    fill_in :image, with: 'https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg'
    fill_in :description, with: 'A brown and white Terrier.'
    fill_in :approximate_age, with: '6'
    fill_in :sex, with: 'male'
    click_on 'Update Pet'

    expect(page).to have_current_path "/pets/#{pet_1.id}"
    expect(page).to have_content ('Sport')
    expect(page).to have_content ('A brown and white Terrier.')

    expect(page).to_not have_content ('Spot')
    expect(page).to_not have_content ('5')
    expect(page).to_not have_content ('energy!')
  end

  it "I am prompted to enter incomplete fields when editing" do
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
    click_on "Update Pet"

    expect(page).to have_current_path "/pets/#{pet_1.id}/edit"

    fill_in :name, with: ""
    fill_in :image, with: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg"
    fill_in :description, with: "A brown and white Terrier."
    fill_in :approximate_age, with: ""
    fill_in :sex, with: "male"
    click_on "Update Pet"

    within "ul.missing-fields" do
      expect(page).to have_content("Name")
      expect(page).to have_content("Approximate_age")
    end
  end

  it "there is a navigation link to shelter index and pet index" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
    pet_1 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      description: "Jack Russell Terrier with tons of energy!",
      approximate_age: "5",
      sex: "male"
    )
    visit "/pets/#{pet_1.id}/edit"
    click_on "All Shelters"
    expect(page).to have_current_path "/shelters"

    visit "/pets/#{pet_1.id}/edit"
    click_on "All Pets"
    expect(page).to have_current_path "/pets"
  end
end
