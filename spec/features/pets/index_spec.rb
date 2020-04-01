require 'rails_helper'

RSpec.describe "pet index page", type: :feature do
  it "can show all pets with their image, name, age, sex, and shelter" do
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
      approximate_age: "5",
      sex: "male"
    )
    pet_2 = shelter_1.pets.create(
      image: "https://c8.alamy.com/comp/2A8F42Y/a-young-white-domestic-shorthair-cat-with-blue-eyes-and-a-surprised-expression-2A8F42Y.jpg",
      name: "Sugar",
      approximate_age: "3",
      sex: "female"
    )
    visit "/pets"

    expect(page).to have_css("img[src*= '#{pet_1.image}']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(shelter_1.name)

    expect(page).to have_css("img[src*= '#{pet_2.image}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.approximate_age)
    expect(page).to have_content(pet_2.sex)
  end

  it "there is a link to Update Pet" do
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
      approximate_age: "5",
      sex: "male"
    )
    visit "/pets"

    click_on 'Update Pet'

    expect(page).to have_current_path "/pets/#{pet_1.id}/edit"
  end

  it "there is a link to Delete Pet" do
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
      approximate_age: "5",
      sex: "male"
    )
    visit "/pets"
    click_on 'Delete'

    expect(page).to have_current_path "/pets"

    expect(page).to_not have_css("img[src*= '#{pet_1.image}']")
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_1.approximate_age)
    expect(page).to_not have_content(pet_1.sex)
    expect(page).to_not have_content(shelter_1.name)
  end

  it "there is a link to the pet's shelter show page" do
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
      approximate_age: "5",
      sex: "male"
    )
    visit "/pets"
    click_on "#{pet_1.shelter.name}"

    expect(page).to have_current_path "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("Address: #{shelter_1.address}")
    expect(page).to have_content("City: #{shelter_1.city}")
    expect(page).to have_content("State: #{shelter_1.state}")
    expect(page).to have_content("Zip: #{shelter_1.zip}")
  end

  it "the pet name is a link to their show page" do
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
      approximate_age: "5",
      sex: "male"
    )
    visit "/pets"
    click_on "#{pet_1.name}"

    expect(page).to have_current_path "/pets/#{pet_1.id}"

    expect(page).to have_css("img[src*= '#{pet_1.image}']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
  end

  it "has a navigation link to shelter index and pet index" do
    visit "/pets"
    click_on "All Shelters"

    expect(page).to have_current_path "/shelters"

    visit "/pets"
    click_on "All Pets"

    expect(page).to have_current_path "/pets"
  end
end
