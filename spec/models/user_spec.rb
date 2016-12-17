require_relative '../spec_helper'

RSpec.describe User do 
  describe "User" do
    it "has an email address" do
      user = build(:user)
      expect(user.email).to eq 'kyle.sponheim@gmail.com'
      expect(user.valid?).to eq true
    end
  end
end