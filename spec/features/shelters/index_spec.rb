require 'rails_helper'

RSpec.describe "shelter index page", type: :feature do
  it "can show all shelters with their name" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
  end

  it "can link to shelter edit page" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters"

    click_on 'Update Shelter'

    expect(page).to have_current_path "/shelters/#{shelter_1.id}/edit"
  end

  it "can delete shelter from index view" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters"

    expect(page).to have_content("Denver Animal Shelter")

    click_on 'Delete'

    expect(page).to have_current_path "/shelters"
    expect(page).to_not have_content(shelter_1.name)
  end

  it "can link to shelter page from shelter name" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters"

    expect(page).to have_content("Denver Animal Shelter")

    click_on 'Denver Animal Shelter'

    expect(page).to have_current_path "/shelters/#{shelter_1.id}"
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.address)
  end

  it "has a navigation link to shelter index and pet index" do
    visit "/shelters"
    click_on "All Shelters"

    expect(page).to have_current_path "/shelters"

    visit "/shelters"
    click_on "All Pets"

    expect(page).to have_current_path "/pets"
  end
end
