require_relative '../spec_helper'

RSpec.describe Game do 
  it "must have two different players" do 
    game = build(:game)
    game.player_two_id = 1
    game.valid?
    expect(game.errors["base"]).to include('Games must have different Players')
  end
end