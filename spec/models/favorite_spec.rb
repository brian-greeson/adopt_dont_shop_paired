require "rails_helper"

RSpec.describe Favorite do
  it "can calculate total favorited pets" do
    favorite = Favorite.new(["1","2","3"])

    expect(favorite.total_count).to eq(3)
  end

  it "can list it's contents" do
    favorite = Favorite.new(["1","2","3"])

    expect(favorite.contents).to eq(["1","2","3"])
  end

  it "can add a pet to its contents" do
    favorite = Favorite.new(["1","2","3"])
    favorite.add_pet(4)

    expect(favorite.contents).to eq(["1","2","3","4"])
  end


end
