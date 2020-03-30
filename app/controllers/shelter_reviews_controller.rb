class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter_review = ShelterReview.new(shelter_review_params)
    if shelter_review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      @shelter = Shelter.find(params[:shelter_id])
      flash.now[:ding_dong] = "Please include a title and content for your review."
      render :new
    end
  end

  def edit
    @shelter_review = ShelterReview.find(params[:review_id])
  end

  def update
    @shelter_review = ShelterReview.find(params[:review_id])
    if @shelter_review.update(shelter_review_params)
      redirect_to "/shelters/#{@shelter_review.shelter_id}"
    else
      @shelter_review = ShelterReview.find(params[:review_id])
      flash.now[:ding_dong] = "Please include a title and content for your review."
      render :edit
    end
  end

  def destroy
    review = ShelterReview.destroy(params[:review_id])
    redirect_to "/shelters/#{review.shelter.id}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image, :shelter_id)
  end
end
