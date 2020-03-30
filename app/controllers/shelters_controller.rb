class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def show
    @shelter = Shelter.find(params[:shelter_id])
  end

  def pet_index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    Shelter.create(shelter_params)
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
  end

  def update
    shelter = Shelter.find(params[:shelter_id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:shelter_id])
    redirect_to '/shelters'
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
