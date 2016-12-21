require_relative '../spec_helper'

RSpec.describe User do 
  describe "User" do
    it "requires an email address" do
      user = create(:user)
      email = user.email
      user.email = nil
      expect(user.valid?).to eq false

      user.email = email
      expect(user.valid?).to eq true
    end
  end
end