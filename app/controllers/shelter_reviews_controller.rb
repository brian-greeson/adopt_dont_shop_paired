class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    ShelterReview.create!({
      title: shelter_review_params[:title],
      image: shelter_review_params[:image],
      content: shelter_review_params[:content],
      rating: shelter_review_params[:rating],
      shelter_id: params[:id]
      })
    redirect_to "/shelters/#{params[:id]}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
