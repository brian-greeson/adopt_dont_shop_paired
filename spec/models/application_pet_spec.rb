require 'rails_helper'

RSpec.describe ApplicationPet do
  describe "relationships" do
    it {should belong_to :pet_application}
    it {should belong_to :pet}
  end
end
