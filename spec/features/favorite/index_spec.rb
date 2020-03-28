require "rails_helper"

RSpec.describe "As a vistor When I have added a pet to my favorite list" do
  it "I can visit the favorite index page and see all my favorite pets" do
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
      name: "Spot 2",
      approximate_age: "2",
      sex: "male"
    )
    pet_3 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_3.jpg",
      name: "Spot 3",
      approximate_age: "4",
      sex: "male"
    )
    visit "/pets/#{pet_1.id}"
    click_link "Add Favorite"
    visit "/pets/#{pet_2.id}"
    click_link "Add Favorite"
    visit ("/favorites")

    expect(page).to have_link(pet_1.name)
    expect(page).to have_css("img[src*= '#{pet_1.image}']")
    expect(page).to have_link(pet_2.name)
    expect(page).to have_css("img[src*= '#{pet_2.image}']")
    expect(page).to_not have_link(pet_3.name)
    expect(page).to_not have_css("img[src*= '#{pet_3.image}']")
  end

  it "I visit that pet's show page, I no longer see a link to favorite that pet" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO", zip: "80223"
    )
    pet_1 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      approximate_age: "51",
      sex: "male"
    )
    visit "/pets/#{pet_1.id}"
    click_link "Add Favorite"
    expect(page).to have_content("Favorites: 1")

    visit "/pets/#{pet_1.id}"

    expect(page).to_not have_link("Add Favorite")
    expect(page).to have_link("Remove Favorite")

    click_link("Remove Favorite")

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_link("Add Favorite")
    expect(page).to_not have_link("Remove Favorite")
    expect(page).to have_content("Favorites: 0")
    expect(page).to have_content("Pet Removed from Favorites! 💔")
  end
end
