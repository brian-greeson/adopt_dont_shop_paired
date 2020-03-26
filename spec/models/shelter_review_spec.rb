require "rails_helper"

describe ShelterReview, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :content}
    it {should validate_presence_of :rating}

    describe "relationships" do
      it {should belong_to :shelter}
    end
  end
end
