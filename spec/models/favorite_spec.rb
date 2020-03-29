require "rails_helper"

RSpec.describe Favorite do
  it "can calculate total favorited pets" do
    favorite = Favorite.new(["1","2","3"])

    expect(favorite.total_count).to eq(3)
  end

  it "can list it's contents" do
    favorite = Favorite.new(["1","2","3"])

    expect(favorite.contents).to eq(["1","2","3"])
  end

  it "can add a pet to its contents" do
    favorite = Favorite.new(["1","2","3"])
    favorite.add_pet(4)

    expect(favorite.contents).to eq(["1","2","3","4"])
  end

  it ".link_text_and_method" do
    favorite = Favorite.new(["1","2","3"])
    add_favorite_link = {:favorite_link_text=>"Add Favorite", :method=>:patch}
    remove_favorite_link = {:favorite_link_text=>"Remove Favorite", :method=>:delete}

    expect(favorite.link_text_and_method("1")).to eq(remove_favorite_link)
    expect(favorite.link_text_and_method("4")).to eq(add_favorite_link)
  end

  it ".remove_pet" do
    favorite = Favorite.new(["1","2","3"])
    favorite.remove_pet(1)

    expect(favorite.contents).to eq(["2","3"])
  end

  it ".remove_pets" do
    favorite = Favorite.new(["1","2","3"])
    favorite.remove_pets(["1","2"])

    expect(favorite.contents).to eq(["3"])
  end

  it ".pets" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223")

    pet_1 = shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      description: "Jack Russell Terrier with tons of energy!",
      approximate_age: "5",
      sex: "male",
      adoption_status: "adoptable"
    )

    pet_2 = shelter_1.pets.create(
      image: "https://c8.alamy.com/comp/2A8F42Y/a-young-white-domestic-shorthair-cat-with-blue-eyes-and-a-surprised-expression-2A8F42Y.jpg",
      name: "Sugar",
      description: "White cat with blue eyes. Very sweet and lovable!",
      approximate_age: "3",
      sex: "female",
      adoption_status: "adoptable"
    )
    
    favorite = Favorite.new([])
    favorite.add_pet(pet_1.id)
    favorite.add_pet(pet_2.id)

    expect(favorite.pets).to eq([pet_1, pet_2])
  end
end
