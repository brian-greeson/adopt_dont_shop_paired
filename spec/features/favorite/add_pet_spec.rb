require "rails_helper"

RSpec.describe "A user I visit " do
  it "any page I see a count of my favorites which is a link that take me to all my favorites" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      approximate_age: "5",
      sex: "male"
    )
    visit "/shelters"
    expect(page).to have_link("Favorites: 0")
    click_link("Favorites: 0")
    expect(current_path).to eq("/favorites")

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link("Favorites: 0")
    click_link("Favorites: 0")
    expect(current_path).to eq("/favorites")

    visit "/pets"
    expect(page).to have_link("Favorites: 0")
    click_link("Favorites: 0")
    expect(current_path).to eq("/favorites")
  end

  it "Pets show page I can click a link to favorite that pet" do
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
    visit "/pets/#{pet_1.id}"
    click_link "Add Favorite"

    expect(current_path).to eq("/pets/#{pet_1.id}")

    within(".flash-message") do
      expect(page).to have_content("#{pet_1.name} has been added to your favorites list ❤️")
    end

    expect(page).to have_link("Favorites: 1")
  end
end
