class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = favorite.contents
    flash[:ding_dong] = "#{pet.name} has been added to your favorites list ❤️"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @pets = []
    Pet.find_each do |pet|
      pet_id_string = pet.id.to_s
      @pets << pet if favorite.contents.include?(pet_id_string)
    end
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite.remove_pet(pet.id)
    session[:favorite] = favorite.contents
    flash[:ding_dong] = "Pet Removed from Favorites! 💔"
    redirect_to "/pets/#{params[:pet_id]}"
  end

end
