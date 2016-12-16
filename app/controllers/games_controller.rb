class GamesController < ApplicationController
  before_action :authorize_players

  def show
    set_user
    @game = Game.find(params["id"])
  end

  private

  def authorize_players
    @game = Game.find(params["id"])
    unless current_user.id == @game.player_one_id || current_user.id == @game.player_two_id
      redirect_to root_url, alert: "You are not playing this game."
    end
  end
end
