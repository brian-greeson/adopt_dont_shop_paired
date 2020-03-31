class PetApplicationsController < ApplicationController
  def new
    @favorite_pets = favorite.pets
  end

  def create
    application = PetApplication.new(pet_applications_params)

    if application.save
      flash[:tah_dah] = "Your application has been received! 🏠"
      favorite.remove_pets(params[:pet_ids])
      redirect_to '/favorites'
    else
      @favorite_pets = favorite.pets
      flash[:wah_wah] = "Please fill out the entire form."
      render :new
    end
  end

  def show
    @application = PetApplication.find(params[:application_id])
  end

  def index
    @heading = "Applicants:"
    @applications = PetApplication.for_pet(params[:pet_id])
    if @applications.empty?
      @heading = "There are no applications for this pet."
    end
  end

  private

  def pet_applications_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, :pet_ids => [])
  end
end
