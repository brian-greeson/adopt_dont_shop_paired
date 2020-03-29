require 'rails_helper'

RSpec.describe "As a visitor when I have added pets to my favorites list" do
  it "On my favorites page I can click a link that brings me to a new application form" do
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

    visit "/pets/#{pet_1.id}"
    click_link "Add Favorite"

    visit ("/favorites")

    click_link "Start Application"

    expect(current_path).to eq("/pet_applications/new")
  end

  it "I can fill in a form to submit a new app for the selected pets and I see a flash message indicating the app went through" do
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

    visit "/pets/#{pet_1.id}"
    click_link "Add Favorite"

    visit "/pets/#{pet_2.id}"
    click_link "Add Favorite"

    visit ("/pet_applications/new")

    fill_in :name, with: 'Steve'
    fill_in :address, with: '123 Main St'
    fill_in :city, with: 'Lakewood'
    fill_in :state, with: 'CO'
    fill_in :zip, with: '80214'
    fill_in :phone_number, with: '9705675555'
    fill_in :description, with: 'I like dogs and will take great care of it.'

    find(:css, "#pet_ids_[value='#{pet_1.id}']").set(true)


    click_button "Submit Application"
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Your application has been received! 🏠")
    expect(page).to_not have_content(pet_1.name)
  end

  it "I cannot leave out information on the application form and get redirected back to the application and get told to finish the form" do
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

    visit "/pets/#{pet_1.id}"
    click_link "Add Favorite"

    visit ("/pet_applications/new")

    fill_in :name, with: ''
    fill_in :address, with: '123 Main St'
    fill_in :city, with: ''
    fill_in :state, with: 'CO'
    fill_in :zip, with: '80214'
    fill_in :phone_number, with: '9705675555'
    fill_in :description, with: 'I like dogs and will take great care of it.'

    find(:css, "#pet_ids_[value='#{pet_1.id}']").set(true)


    click_button "Submit Application"
    expect(page).to have_content("Please fill out the entire form.")
    expect(page).to have_selector('input[type=submit]')
  end
end
