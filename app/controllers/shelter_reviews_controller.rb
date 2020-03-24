class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end
end
