class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents
  end

  def total_count
    @contents.count
  end

end
