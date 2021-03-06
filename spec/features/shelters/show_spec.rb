require 'rails_helper'

RSpec.describe "shelter page", type: :feature do
  it "Can click on shelter name to reload shelter show page" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters/#{shelter_1.id}"
    click_link "#{shelter_1.name}"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
  end

  it "can show individual shelters with their details" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("Address: #{shelter_1.address}")
    expect(page).to have_content("City: #{shelter_1.city}")
    expect(page).to have_content("State: #{shelter_1.state}")
    expect(page).to have_content("Zip: #{shelter_1.zip}")
  end

  it 'I can delete a shelter and all its pets go with it' do
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
      description: "A dog",
      sex: "male"
    )
    pet_2 = shelter_2.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spike",
      approximate_age: "5",
      description: "A dog",
      sex: "male"
    )
    visit "/shelters/#{shelter_1.id}"
    click_link 'Delete'

    expect(current_path).to eq('/shelters')
    expect(page).to_not have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)

    visit "/pets"

    expect(page).to_not have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end

  it "I cannot delete a shelter that has approved applications" do
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
    PetApplication.create(
      name: 'Steve',
      address: '123 Main St',
      city: 'Lakewood',
      state: 'CO',
      zip: '80214',
      phone_number: '9705675555',
      description: 'I like dogs and will take great care of it.',
      pet_ids: [pet_1.id]
    )
    PetApplication.create(
      name: 'Brian',
      address: '123 Main St',
      city: 'Lakewood',
      state: 'CO',
      zip: '80214',
      phone_number: '9705675555',
      description: 'I like dogs and will take great care of it.',
      pet_ids: [pet_1.id]
    )
    app_to_pet_1 = ApplicationPet.find_by(pet_id: pet_1.id)
    app_to_pet_1.approve

    visit "/shelters/#{shelter_1.id}"

    expect(page).to_not have_link("Delete")
  end

  it "there is the count of the number of pets at shelter" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO", zip: "80223"
    )
    shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "Spot",
      approximate_age: "5",
      sex: "male"
    )
    shelter_1.pets.create(
      image: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Jack_Russell_Terrier_1.jpg",
      name: "S24rt",
      approximate_age: "5",
      sex: "male"
    )
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Total Pets: 2")
  end

  it "There is the average shelter review rating" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO", zip: "80223"
    )
    shelter_1.shelter_reviews.create(
      title: "My review",
      content: "tacoTacotaco",
      image: "http://www.wikipedia.com/1234.jpg",
      rating: 1
    )
    shelter_1.shelter_reviews.create(
      title: "My review",
      content: "tacoTacotaco",
      image: "http://www.wikipedia.com/1234.jpg",
      rating: 2
    )
    shelter_1.shelter_reviews.create(
      title: "My review",
      content: "tacoTacotaco",
      image: "http://www.wikipedia.com/1234.jpg",
      rating: 3
    )
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Average Rating: 2.0")

    shelter_1.shelter_reviews.create(
      title: "My review",
      content: "tacoTacotaco",
      image: "http://www.wikipedia.com/1234.jpg",
      rating: 3
    )
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Average Rating: 2.3")
  end

  it "there is number of applications on file at that shelter" do
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
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Applications on File: 0")

    PetApplication.create(
      name: 'Steve',
      address: '123 Main St',
      city: 'Lakewood',
      state: 'CO',
      zip: '80214',
      phone_number: '9705675555',
      description: 'I like dogs and will take great care of it.',
      pet_ids: [pet_1.id]
    )
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Applications on File: 1")

    PetApplication.create(
      name: 'Steve',
      address: '123 Main St',
      city: 'Lakewood',
      state: 'CO',
      zip: '80214',
      phone_number: '9705675555',
      description: 'I like dogs and will take great care of it.',
      pet_ids: [pet_1.id]
    )
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Applications on File: 2")
  end

  it "there is a navigation link to shelter index and pet index" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters/#{shelter_1.id}"
    click_on "All Shelters"
    expect(page).to have_current_path "/shelters"

    visit "/shelters/#{shelter_1.id}"
    click_on "All Pets"
    expect(page).to have_current_path "/pets"
  end
end
