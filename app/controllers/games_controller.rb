class GamesController < ApplicationController
  before_action :authorize_players, :set_user, :authenticate_user
  skip_before_action :authorize_players, only: [:index, :new, :create]
  skip_before_action :authenticate_user, only: [:show, :match_cards, :show_guesses]

  def index
    @games = User.find(params[:user_id]).games
  end

  def show
    @game = Game.find(params["id"])
    @cards = Card.where(game_id: @game.id).order(position: :asc)
    Matcher.hide_cards(@game.cards)
  end

  def match_cards
    redirect_to game_path(id: params[:id]), flash: {alert: "Please select two cards"} and return if params[:card_ids].count != 2 
    c1 = Card.find params[:card_ids].first
    c2 = Card.find params[:card_ids].last
    Matcher.compare(c1, c2)
    redirect_to show_guesses_path(id: params[:id], card_ids: params[:card_ids])
  end

  def show_guesses
    @game = Game.find(params["id"])
    @cards = Card.where(game_id: @game.id).order(position: :asc)
    redirect_to game_path(id: params[:id]), flash: {alert: "It is not your turn to guess"} and return if @user.id != @game.current_player_id
    c1 = Card.find params[:card_ids].first
    c2 = Card.find params[:card_ids].last
    @game.update_current_player
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
