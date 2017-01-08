require 'rails_helper'

RSpec.describe UserPerformance, type: :model do
  before do
    @user = create(:user)
    @user_performance = @user.user_performance
  end

  it "#increment_wins adds 1 to wins" do
    expect{@user_performance.increment_wins}.to change{@user_performance.wins}.by(1)
  end

  it "#increment_wins calls #increment_games_completed" do
    expect(@user_performance).to receive(:increment_games_completed)

    @user_performance.increment_wins
  end

  it "#increment_losses adds 1 to losses" do
    expect{@user_performance.increment_losses}.to change{@user_performance.losses}.by(1)
  end

  it "#increment_losses calls #increment_games_completed" do
    expect(@user_performance).to receive(:increment_games_completed)

    @user_performance.increment_losses
  end

  it "#increment_games_completed adds 1 to games_completed" do
    expect{@user_performance.increment_games_completed}.to change{@user_performance.games_completed}.by(1)
  end

  describe "#calculate_win_loss_ratio" do 
    context "when games_won is 0" do
      it "returns 0" do
        @user_performance.games_completed = 0
        @user_performance.calculate_win_loss_ratio
        expect(@user_performance.win_loss_ratio).to eq(0)
      end
    end

    context "when games_won is greater than 0" do 
      it "returns the quotient of wins and losses as a float" do
        @user_performance.games_completed = 4
        @user_performance.wins = 2
        @user_performance.losses = 1

        @user_performance.calculate_win_loss_ratio
        expect(@user_performance.win_loss_ratio.class).to eq(Float)
        expect(@user_performance.win_loss_ratio).to eq(2)

        @user_performance.wins = 1
        @user_performance.losses = 2
        
        @user_performance.calculate_win_loss_ratio
        expect(@user_performance.win_loss_ratio.class).to eq(Float)
        expect(@user_performance.win_loss_ratio).to eq(0.5)
      end
    end
  end
end
