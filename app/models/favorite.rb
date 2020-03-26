class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def add_pet(pet_id)
    @contents << pet_id.to_s
  end

  def total_count
    @contents.count
  end

end
