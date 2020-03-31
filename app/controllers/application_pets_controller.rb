class ApplicationPetsController < ApplicationController

  def approve
    ApplicationPet.find_by(application_pets_params).approve
    redirect_to "/pets/#{params[:pet_id]}"
  end

  private

  def application_pets_params
    params.permit(:application_id, :pet_id)
  end
end
