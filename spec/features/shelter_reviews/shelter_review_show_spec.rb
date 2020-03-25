require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "When I visit a shelter's show page, I can click on a link to add a review" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

    visit "/shelters/#{shelter_1.id}"

    click_on "Add Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

  end

  it "When I visit the shelter review page I see a form to create a review" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

    visit "/shelters/#{shelter_1.id}/reviews/new"

    fill_in :title, with: 'Go Marge!'
    select 5, from: :rating
    fill_in :content, with: "This is the best shelter ever! Marge at the front desk is the best ever!"
    fill_in :image, with: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"

    click_button "Submit Review"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content('Marge')
    save_and_open_page
  end
end
