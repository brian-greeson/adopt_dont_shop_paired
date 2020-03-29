class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def pets
    @favorite_pets = []
    Pet.find_each do |pet|
      pet_id_string = pet.id.to_s
      @favorite_pets << pet if contents.include?(pet_id_string)
    end
    @favorite_pets
  end

  def add_pet(pet_id)
    @contents << pet_id.to_s
  end

  def remove_pet(pet_id)
    @contents.delete(pet_id.to_s)
  end

  def remove_pets(pet_ids)
    pet_ids.each do |id|
      @contents.delete(id.to_s)
    end
  end

  def total_count
    @contents.count
  end

  def link_text_and_method(pet_id)
    favorite_link = {}
    if contents.include?(pet_id.to_s)
      favorite_link[:favorite_link_text] = "Remove Favorite"
      favorite_link[:method] = :delete
    else
      favorite_link[:favorite_link_text] = "Add Favorite"
      favorite_link[:method] = :patch
    end
    favorite_link
  end

end
