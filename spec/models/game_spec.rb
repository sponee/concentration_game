require_relative '../spec_helper'

RSpec.describe Game do 

  before do
    @game = build(:game)
    @user = create(:user)
    @player_two = create(:user)
  end

  it "belongs to a player" do
    @game.user_id = @user.id
    @game.player_one_id, @game.player_two_id = @user.id, @player_two.id
    expect(@game.valid?).to eq(true)
  end

  it "must have two different players" do 
    @game.player_one_id = 1
    @game.player_two_id = 1
    @game.valid?
    expect(@game.errors["base"]).to include('Games must have different Players')
  end

  it "generates 18 Cards after being created" do 
    expect(@game.cards.count).to eq(0)
    @game.update_attributes!(user_id: @user.id, player_one_id: @user.id, player_two_id: @player_two.id)
    expect(@game.cards.count).to eq(18)
  end

  it "sets its owner as the current_player after being created" do
    @game.user_id = @user.id
    expect(@game.current_player_id).to eq(nil)
    @game.save
    expect(@game.current_player_id).to eq(@user.id)
  end

  it "#update_current_player swaps current_player_id" do
    @game.user_id = @user.id
    @game.save
    
    expect(@game.current_player_id).to eq(@user.id)
    @game.update_current_player
    expect(@game.current_player_id).to eq(@player_two.id)
  end

  it "#update_score increments the given player's score by one" do
    @game.user_id = @user.id
    @game.save

    expect(@game.player_one_score).to eq(0)
    @game.update_score(@user.id)
    expect(@game.player_one_score).to eq(1)
  end

  describe "#end_game" do 
    it "sets the winner_id based on scores with 5 matched pairs" do
      @game.user_id = @user.id
      @game.player_one_id, @game.player_two_id = @user.id, @player_two.id
      @game.save
      @game.cards.limit(10).update_all(matched: true)

      expect(@game.winner_id).to eq(nil)

      @game.update_attributes(player_one_score: 5, player_two_score: 0)

      @game.end_game
      expect(@game.winner_id).to eq(@user.id)
    end

    it "does nothing with less than 5 matched pairs" do
      @game.user_id = @user.id
      @game.player_one_id, @game.player_two_id = @user.id, @player_two.id
      @game.save
      @game.cards.limit(8).update_all(matched: true)

      expect(@game.winner_id).to eq(nil)
      @game.update_attributes(player_one_score: 4, player_two_score: 0)

      @game.end_game
      expect(@game.winner_id).to eq(nil)
    end
  end
end