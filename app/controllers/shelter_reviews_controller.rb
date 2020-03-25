class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])

    shelter_review = ShelterReview.new({
      title: shelter_review_params[:title],
      image: shelter_review_params[:image],
      content: shelter_review_params[:content],
      rating: shelter_review_params[:rating],
      shelter_id: params[:id]
      })

    if shelter_review.save
      redirect_to "/shelters/#{params[:id]}"
    else
      flash.now[:ding_dong] = "Please include a title and content for your review."
      render :new
    end
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
