class PetApplicationsController < ApplicationController
  def new
    @favorite_pets = favorite.pets
  end

  def create
    application = PetApplication.new(
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      phone_number: params[:phone_number],
      description: params[:description],
      pet_ids: params[:pet_ids]
    )

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

  def approve
    pet = Pet.find(params[:pet_id])
    application = PetApplication.find(params[:application_id])
    pet.update(
      adoption_status: "pending",
      applicant: application.name
    )
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
