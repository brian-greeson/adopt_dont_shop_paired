require 'rails_helper'


RSpec.describe 'As a visitor' do
  describe 'When I visit a shelter pet index page there is a link to create a pet and' do
    it "I can create a new adoptable pet" do
      shelter_1 = Shelter.create(
        name: "Denver Animal Shelter",
        address: "1241 W Bayaud Ave",
        city: "Denver",
        state: "CO",
        zip: "80223"
      )
      visit "/shelters/#{shelter_1.id}/pets"

      click_link 'Create Pet'

      expect(page).to have_current_path "/shelters/#{shelter_1.id}/pets/new"

      fill_in :name, with: 'Marco'
      fill_in :image, with: 'https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg'
      fill_in :description, with: 'A sweet little hoggo with a big personality!'
      fill_in :approximate_age, with: '1'
      fill_in :sex, with: 'male'

      click_button 'Create Pet'

      new_pet = shelter_1.pets.last
      expect(page).to have_current_path "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_content ('Marco')
      expect(new_pet.adoption_status).to eql('adoptable')
    end

  it "I am prompted to enter incomplete fields when editing" do
    shelter_1 = Shelter.create(
      name: "Denver Animal Shelter",
      address: "1241 W Bayaud Ave",
      city: "Denver",
      state: "CO",
      zip: "80223"
    )
    visit "/shelters/#{shelter_1.id}/pets"

    click_link "Create Pet"

    expect(page).to have_current_path "/shelters/#{shelter_1.id}/pets/new"

    fill_in :name, with: ""
    fill_in :image, with: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"
    fill_in :description, with: "A sweet little hoggo with a big personality!"
    fill_in :approximate_age, with: "1"
    fill_in :sex, with: ""

    click_button "Create Pet"

    within "ul.missing-fields" do
      expect(page).to have_content("Name")
      expect(page).to have_content("Sex")
    end
  end
  
    it "there is a navigation link to shelter index and pet index" do
      shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

      visit "/shelters/#{shelter_1.id}/pets/new"
      click_on "All Shelters"
      expect(page).to have_current_path "/shelters"

      visit "/shelters/#{shelter_1.id}/pets/new"
      click_on "All Pets"
      expect(page).to have_current_path "/pets"
    end
  end
end
