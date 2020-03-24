require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "When I visit a shelter's show page, I can click on a link to add a review" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

    visit "/shelters/#{shelter_1.id}"

    click_on "Add Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

  end
end
