require "rails_helper"

RSpec.describe "A user I visit any page" do
  it "I can see a count of my favorite pets" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

    pet_1 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      approximate_age: "5",
      sex: "male")

      visit "/shelters"
      expect(page). to have_content("Favorites: 0")
      visit "/shelters/#{shelter_1.id}"
      expect(page). to have_content("Favorites: 0")
      visit "/pets"
      expect(page). to have_content("Favorites: 0")

  end



end
