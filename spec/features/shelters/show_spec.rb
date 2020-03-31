require 'rails_helper'

RSpec.describe "shelter page", type: :feature do
  it "can show individual shelters with their details" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("Address: #{shelter_1.address}")
    expect(page).to have_content("City: #{shelter_1.city}")
    expect(page).to have_content("State: #{shelter_1.state}")
    expect(page).to have_content("Zip: #{shelter_1.zip}")
  end

  it 'I can delete a shelter' do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
    shelter_2 = Shelter.create(name: "Aurora Animal Shelter", address: "15750 E 32nd Ave", city: "Aurora", state: "CO", zip: "80011")

    visit "/shelters/#{shelter_1.id}"

    click_link 'Delete'

    expect(current_path).to eq('/shelters')
    expect(page).to_not have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end


  it "there is a navigation link to shelter index and pet index" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
    visit "/shelters/#{shelter_1.id}"
    click_on "All Shelters"
    expect(page).to have_current_path "/shelters"

    visit "/shelters/#{shelter_1.id}"
    click_on "All Pets"
    expect(page).to have_current_path "/pets"
  end

end
