require 'rails_helper'

RSpec.describe "pet index page", type: :feature do
  it "can show all pets with their image, name, age, and sex" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    shelter_2 = Shelter.create(
      name: "Aurora Animal Shelter",
      address: "15750 E 32nd Ave",
      city: "Aurora",
      state: "CO",
      zip: "80011"
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
    pet_3 = shelter_2.pets.create(
      image: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg",
      name: "Sonic",
      approximate_age: "1",
      sex: "male"
    )
    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_css("img[src*= '#{pet_1.image}']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)

    expect(page).to have_css("img[src*= '#{pet_2.image}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.approximate_age)
    expect(page).to have_content(pet_2.sex)

    expect(page).to_not have_css("img[src*= '#{pet_3.image}']")
    expect(page).to_not have_content(pet_3.name)
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

  it "there is a navigation link to shelter index and pet index" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters/#{shelter_1.id}/pets"
    click_on "All Shelters"
    expect(page).to have_current_path "/shelters"

    visit "/shelters/#{shelter_1.id}/pets"
    click_on "All Pets"
    expect(page).to have_current_path "/pets"
  end
end
