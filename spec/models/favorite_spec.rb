require "rails_helper"

RSpec.describe Favorite do
  it "can calculate total favorited pets" do
    favorite = Favorite.new([1,2,3])

    expect(favorite.total_count).to eq(3)

  end

end
