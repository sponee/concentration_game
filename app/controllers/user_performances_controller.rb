class UserPerformancesController < ApplicationController
  def show
    set_user
    @user_performance = UserPerformance.find_by_user_id(params[:id])
    @completed_games = Game.completed.where(player_one_id: params[:id]).or(Game.completed.where(player_two_id: params[:id])).limit(5)
  end

  def leaderboard
    set_user
    @leaders = UserPerformance.order(win_loss_ratio: :desc, games_completed: :desc).limit(13)
  end
end