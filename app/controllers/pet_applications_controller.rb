class PetApplicationsController < ApplicationController
  def new
    @favorite_pets = []
    Pet.find_each do |pet|
      pet_id_string = pet.id.to_s
      @favorite_pets << pet if favorite.contents.include?(pet_id_string)
    end
  end

  def create
    PetApplication.create(
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      phone_number: params[:phone_number],
      description: params[:description],
      pet_ids: params[:pet_ids]
    )

    favorite.remove_pets(params[:pet_ids])

    flash[:tah_dah] = "Your application has been received! 🏠"
    redirect_to '/favorites'
  end
end
