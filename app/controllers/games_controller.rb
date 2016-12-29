class GamesController < ApplicationController
  before_action :authorize_players, :set_user, :authenticate_user
  skip_before_action :authorize_players, only: [:index, :new, :create]
  skip_before_action :authenticate_user, only: [:show, :match_cards]

  def index
    @games = User.find(params[:user_id]).games
  end

  def show
    @game = Game.find(params["id"])
  end

  def match_cards
    redirect_to game_path(id: params[:id]), flash: {alert: "Please select two cards"} if params[:card_ids].count != 2 
    c1 = Card.find params[:card_ids].first
    c2 = Card.find params[:card_ids].last
    Matcher.compare(c1, c2)
    redirect_to game_path(id: params[:id])
  end

  private

  def authenticate_user
    set_user
    redirect_to root_url, alert: "You are not authorized to view this content." if current_user != User.find(params["user_id"])
  end

  def authorize_players
    @game = Game.find(params["id"])
    unless set_user && [@game.player_one_id, @game.player_two_id].include?(current_user.id)
      redirect_to root_url, alert: "You are not playing this game."
    end
  end
end
