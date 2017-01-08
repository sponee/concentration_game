require 'rails_helper'

RSpec.describe UserPerformance, type: :model do
  before do
    @user = create(:user)
    @user_performance = @user.user_performance
  end

  it "#increment_wins adds 1 to self.wins" do
    expect{@user_performance.increment_wins}.to change{@user_performance.wins}.by(1)
  end

  it "#increment_wins calls #increment_games_completed" do
    expect(@user_performance).to receive(:increment_games_completed)

    @user_performance.increment_wins
  end

  it "#increment_losses adds 1 to self.losses" do
    expect{@user_performance.increment_losses}.to change{@user_performance.losses}.by(1)
  end

  it "#increment_losses calls #increment_games_completed" do
    expect(@user_performance).to receive(:increment_games_completed)

    @user_performance.increment_losses
  end

  it "#increment_games_completed adds 1 to self.games_completed" do
    expect{@user_performance.increment_games_completed}.to change{@user_performance.games_completed}.by(1)
  end
end
