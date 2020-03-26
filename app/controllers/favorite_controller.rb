class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = favorite.contents
    flash[:ding_dong] = "#{pet.name} has been added to your favorites list ❤️"
    redirect_to "/pets/#{params[:pet_id]}"
  end

end
# flash[:notice] = "You now have #{session[:favorite][song_id_str]} copy of #{song.title} in your cart."
# pet_id_string = pet.id.to_s
