class GamesController < ApplicationController
  before_action :authorize_players, :set_user

  def show
    @game = Game.find(params["id"])
  end

  private

  def authorize_players
    @game = Game.find(params["id"])
    unless set_user && [@game.player_one_id, @game.player_two_id].include?(current_user.id)
      redirect_to root_url, alert: "You are not playing this game."
    end
  end
end
