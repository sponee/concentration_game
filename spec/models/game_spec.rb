require_relative '../spec_helper'

RSpec.describe Game do 
  it "must have two different players" do 
    game = build(:game)
    game.player_one_id = 1
    game.player_two_id = 1
    game.valid?
    expect(game.errors["base"]).to include('Games must have different Players')
  end

  it "belongs to a player" do
    user = create(:user)
    game = build(:game)
    game.user_id = user.id
    game.player_one_id, game.player_two_id = user.id, 2
    expect(game.valid?).to eq(true)
  end
end