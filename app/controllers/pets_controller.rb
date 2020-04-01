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
    pet = Pet.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
    else
      flash.now[:incomplete_form] = pet.errors.messages.keys
      @shelter = Shelter.find(params[:shelter_id])
      render :new
    end
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    @pet = Pet.find(params[:pet_id])
    if @pet.update(pet_params)
      redirect_to "/pets/#{@pet.id}"
    else
      flash.now[:incomplete_form] = @pet.errors.messages.keys
      render :edit
    end
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
