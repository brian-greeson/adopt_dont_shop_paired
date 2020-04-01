class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def show
    @pet = Pet.find(params[:pet_id])
    @favorite_link = favorite.link_text_and_method(@pet.id)

  end

  def create
    Pet.create(pet_params)
    redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:pet_id])
    favorite.remove_pet(params[:pet_id])
    redirect_to '/pets'
  end

  private
  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex, :shelter_id)
  end
end
