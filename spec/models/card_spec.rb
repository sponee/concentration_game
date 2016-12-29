require 'rails_helper'

RSpec.describe Card, type: :model do
  it "belongs to a game" do 
    c = build(:card)
    c.valid?
    expect(c.errors[:game]).to include("must exist")
  end
end
