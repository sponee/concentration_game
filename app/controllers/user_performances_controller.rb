class UserPerformancesController < ApplicationController
  def show
    set_user
    @user_performance = UserPerformance.find_by_user_id(params[:id])
    @completed_games = Game.completed.where(player_one_id: params[:id]) + (Game.completed.where(player_two_id: params[:id]))
  end

  def leaderboard
    set_user
    @leaders = UserPerformance.order(games_completed: :desc, win_loss_ratio: :desc).limit(13)
  end
end