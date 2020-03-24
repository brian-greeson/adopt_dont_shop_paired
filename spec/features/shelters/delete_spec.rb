require 'rails_helper'

RSpec.describe 'As a Visitor' do
  it 'I can delete a shelter' do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
    shelter_2 = Shelter.create(name: "Aurora Animal Shelter", address: "15750 E 32nd Ave", city: "Aurora", state: "CO", zip: "80011")

    visit "/shelters/#{shelter_1.id}"

    click_link 'Delete'

    expect(current_path).to eq('/shelters')
    expect(page).to_not have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end
end
