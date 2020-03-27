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

    visit pets_show_path(pet_1)
    click_link "Add Favorite"
    visit ("/favorites")

    expect(page).to have_link(pet_1.name)
    expect(page).to have_css("img[src*= '#{pet_1.image}']")

  end

end
