require 'rails_helper'

RSpec.describe Card, type: :model do
  it "belongs to a user" do 
    c = build(:card)
    c.valid?
    expect(c.errors.first).to include("must exist")
  end
end
