require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "When I visit a shelter's show page, I can click on a link to edit a review" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")

    review_1 =  shelter_1.shelter_reviews.create(
      title: "Go Marge!",
      content: "This is the best shelter ever! Marge at the front desk is the best ever!",
      rating: 5,
      image: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"
    )
    visit "/shelters/#{shelter_1.id}"

    click_on "Edit Review"

    expect(current_path).to eq("/reviews/#{review_1.id}/edit")

  end

  describe "When I visit the shelter review edit page I see a form to edit a review" do
    it "I can edit a shelter review" do
      shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
      review_1 = shelter_1.shelter_reviews.create(
        title: "Go Marge!",
        content: "This is the best shelter ever! Marge at the front desk is the best ever!",
        rating: 5,
        image: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"
      )

      visit "/shelters/#{shelter_1.id}"

      click_on "Edit Review"

      expect(current_path).to eq("/reviews/#{review_1.id}/edit")

      fill_in :title, with: 'Go Away Mary!'
      select 1, from: :rating
      fill_in :content, with: "This is the worst shelter ever! Mary at the front desk is the worst ever!"
      fill_in :image, with: "https://s2.storage.snapzu.com/fe/9e/a0/10/Snapzucom/snaps/38/dc/40512/modules/39409/1/bf6ed7f7877433db_medium.jpg"

      click_button "Update Review"

      expect(page).to have_content('Go Away Mary')
      expect(page).to have_content("This is the worst shelter ever! Mary at the front desk is the worst ever!")
      expect(page).to have_css("img[src*= 'https://s2.storage.snapzu.com/fe/9e/a0/10/Snapzucom/snaps/38/dc/40512/modules/39409/1/bf6ed7f7877433db_medium.jpg']")

      expect(page).to_not have_content('Go Marge!')
      expect(page).to_not have_content("This is the best shelter ever! Marge at the front desk is the best ever!")
      expect(page).to_not have_css("img[src*= 'https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg']")
    end

    it "I cannot edit a review without a title" do
      shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
      review_1 = shelter_1.shelter_reviews.create(
        title: "Go Marge!",
        content: "This is the best shelter ever! Marge at the front desk is the best ever!",
        rating: 5,
        image: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"
      )

      visit "/shelters/#{shelter_1.id}"

      click_on "Edit Review"

      expect(current_path).to eq("/reviews/#{review_1.id}/edit")
      fill_in :title, with: ''
      select 1, from: :rating
      fill_in :content, with: "This is the worst shelter ever! Mary at the front desk is the worst ever!"
      fill_in :image, with: "https://s2.storage.snapzu.com/fe/9e/a0/10/Snapzucom/snaps/38/dc/40512/modules/39409/1/bf6ed7f7877433db_medium.jpg"

      click_button "Update Review"

      expect(page).to have_selector("input[value='Go Marge!']")
      expect(page).to have_content('Please include a title and content for your review.')
      expect(page).to have_selector('input[type=submit]')
    end

    it "I cannot edit a review without content" do
      shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
      shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
      review_1 = shelter_1.shelter_reviews.create(
        title: "Go Marge!",
        content: "This is the best shelter ever! Marge at the front desk is the best ever!",
        rating: 5,
        image: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"
      )

      visit "/shelters/#{shelter_1.id}"

      click_on "Edit Review"

      expect(current_path).to eq("/reviews/#{review_1.id}/edit")

      fill_in :title, with: 'Go Away Mary!'
      select 1, from: :rating
      fill_in :content, with: ""
      fill_in :image, with: "https://s2.storage.snapzu.com/fe/9e/a0/10/Snapzucom/snaps/38/dc/40512/modules/39409/1/bf6ed7f7877433db_medium.jpg"

      click_button "Update Review"

      expect(page).to have_selector("input[value='Go Marge!']")
      expect(page).to have_content('Please include a title and content for your review.')
      expect(page).to have_selector('input[type=submit]')
    end

  end
end
