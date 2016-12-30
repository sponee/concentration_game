require_relative '../spec_helper'

RSpec.describe Game do 

  before do
    @game = build(:game)
    @user = create(:user)
    @player_two = create(:user)
  end

  it "must have two different players" do 
    @game.player_one_id = 1
    @game.player_two_id = 1
    @game.valid?
    expect(@game.errors["base"]).to include('Games must have different Players')
  end

  it "belongs to a player" do
    @game.user_id = @user.id
    @game.player_one_id, @game.player_two_id = @user.id, @player_two.id
    expect(@game.valid?).to eq(true)
  end

  it "has exactly 18 cards created after the game is created" do 
    expect(@game.cards.count).to eq(0)
    @game.update_attributes!(user_id: @user.id, player_one_id: @user.id, player_two_id: @player_two.id)
    expect(@game.cards.count).to eq(18)
  end
end