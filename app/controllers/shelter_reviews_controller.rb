class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
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
      @shelter = Shelter.find(params[:id])
      flash.now[:ding_dong] = "Please include a title and content for your review."
      render :new
    end
  end

  def edit
    @shelter_review = ShelterReview.find(params[:review_id])
  end

  def update
    @shelter_review = ShelterReview.find(params[:review_id])
    if @shelter_review.update({
        title: shelter_review_params[:title],
        content: shelter_review_params[:content],
        image: shelter_review_params[:image],
        rating: shelter_review_params[:rating],
      })
      redirect_to "/shelters/#{@shelter_review.shelter_id}"
    else
      @shelter_review = ShelterReview.find(params[:review_id])
      flash.now[:ding_dong] = "Please include a title and content for your review."
      render :edit
    end
  end

  def destroy
    review = ShelterReview.destroy(params[:review_id])
    redirect_to shelters_show_path(review.shelter.id)
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
