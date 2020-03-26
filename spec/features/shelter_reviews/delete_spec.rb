require "rails_helper"

RSpec.describe "when A user visits a shelter show page" do
  it "I can click a link next to each shelter review to delete the review" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter", address: "1241 W Bayaud Ave", city: "Denver", state: "CO", zip: "80223")
    review_1 =  shelter_1.shelter_reviews.create(
      title: "review 1 title",
      content: "review 1 content",
      rating: 1,
      image: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"
    )
    review_2 =  shelter_2.shelter_reviews.create(
      title: "review 2 title",
      content: "review 2 content",
      rating: 2,
      image: "https://s3.amazonaws.com/petcoach-api-prod-uploads/uploads/noslidesarticleimages/0a4d267ac1b94cdc12690b7f503822bf.jpg"
    )

    visit "/sheleters/#{shelter_1.id}"

    within("#review-#{review_1.id}-details") do
      click_link "Delete Review"
    end

    expect(current_path).to eq("/shetlers/#{shelter_1.id}")

    within(".shelter_reviews") do
      expect(page).to_not have_content(review_1.title)
      expect(page).to have_content(review_2.title)
    end

  end

end
