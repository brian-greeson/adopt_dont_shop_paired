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

  it ".link_text_and_method" do
    favorite = Favorite.new(["1","2","3"])
    add_favorite_link = {:favorite_link_text=>"Add Favorite", :method=>:patch}
    remove_favorite_link = {:favorite_link_text=>"Remove Favorite", :method=>:delete}

    expect(favorite.link_text_and_method("1")).to eq(remove_favorite_link)
    expect(favorite.link_text_and_method("4")).to eq(add_favorite_link)
  end
end
