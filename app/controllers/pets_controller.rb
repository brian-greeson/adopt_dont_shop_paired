class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def show
    @pet = Pet.find(params[:pet_id])
    @favorite_link = favorite.link_text_and_method(@pet.id)
  end

  def create
    Pet.create({
      name: pet_params[:name],
      image: pet_params[:image],
      description: pet_params[:description],
      approximate_age: pet_params[:approximate_age],
      sex: pet_params[:sex],
      adoption_status: "adoptable",
      shelter_id: params[:id]
    })
    redirect_to "/shelters/#{params[:id]}/pets"
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.update({
      name: pet_params[:name],
      image: pet_params[:image],
      description: pet_params[:description],
      approximate_age: pet_params[:approximate_age],
      sex: pet_params[:sex],
      })
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end
  
  private
  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex)
  end
end
