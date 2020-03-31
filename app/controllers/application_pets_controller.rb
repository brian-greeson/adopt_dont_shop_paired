class ApplicationPetsController < ApplicationController

  def update
    if ApplicationPet.find_by(application_pets_params).status == "open"
      approve
      redirect_to "/pets/#{params[:pet_id]}"
    else
      revoke
      redirect_to "/pet_applications/#{params[:pet_application_id]}"
    end
  end

  private

  def application_pets_params
    params.permit(:application_id, :pet_id)
  end

  def approve
    ApplicationPet.find_by(application_pets_params).approve
  end

  def revoke
    ApplicationPet.find_by(application_pets_params).revoke
  end
end
