class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = favorite.contents
    flash[:ding_dong] = "#{pet.name} has been added to your favorites list ❤️"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @heading = "You have no favorite pets 💔"
    @pets = favorite.pets
    if !favorite.contents.empty?
      @heading = "My Favorites ❤️"
    end
    @pets_with_applications = PetApplication.pets
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite.remove_pet(pet.id)
    session[:favorite] = favorite.contents
    flash[:ding_dong] = "Pet Removed from Favorites! 💔"
    redirect_back fallback_location: root_path
  end

  def destroy_all
    session[:favorite].clear
    redirect_to "/favorites"
  end
end
