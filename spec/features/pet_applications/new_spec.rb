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
end
