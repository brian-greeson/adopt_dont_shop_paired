require 'rails_helper'

RSpec.describe 'As a Visitor' do
  it 'I can delete a pet' do
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
    visit "/pets/#{pet_1.id}"

    click_link 'Delete'

    expect(current_path).to eq('/pets')
    expect(page).to_not have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end

  it "When I delete a favorited pet it is removed from my favorites and the favorite count decreases by 1" do
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
    visit "/pets/#{pet_1.id}"
    click_link "Add Favorite"
    visit "/pets/#{pet_2.id}"
    click_link "Add Favorite"

    visit "/pets/#{pet_1.id}"
    click_link "Delete"

    visit "/favorites"

    expect(page).to_not have_content(pet_1.name)
    expect(page).to have_content("Favorites: 1")
  end
end
