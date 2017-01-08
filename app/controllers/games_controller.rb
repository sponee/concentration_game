class GamesController < ApplicationController
  before_action :authorize_players, :set_user, :authenticate_user
  skip_before_action :authorize_players, only: [:index, :new, :create]
  skip_before_action :authenticate_user, only: [:show, :match_cards, :show_guesses]

  def index
    @games_in_progress = Game.active.where(player_one_id: @user.id).or(Game.active.where(player_two_id: @user.id))
    @completed_games = Game.completed.where(player_one_id: @user.id).or(Game.completed.where(player_two_id: @user.id)).limit(10)
  end

  def new
    @game = @user.games.new
  end

  def create
    redirect_to new_user_game_path(@user), flash: {alert: "That person is not registered to play."} and return unless User.find_by_username(params[:challenger_username])
    @game = @user.games.new(player_one_id: @user.id, player_two_id: User.find_by_username(params[:challenger_username]).id)
    if @game.save
       redirect_to show_game_path(id: @game), notice: "Let the game begin!"
    else
       render :new
    end
  end

  def show
    @trivia = Trivia::TRIVIA.to_a.sample
    @game = Game.find(params["id"])
    @cards = Card.where(game_id: @game.id).order(position: :asc).to_ary
    Matcher.hide_matchables(@game.cards)
  end

  def match_cards
    redirect_to show_game_path(id: params[:id]), flash: {alert: "Please select two cards"} and return if params[:card_ids].nil? || params[:card_ids].count != 2 
    @game = Game.find(params[:id])
    c1 = Card.find params[:card_ids].first
    c2 = Card.find params[:card_ids].last
    @game.update_score(@game.current_player_id) if Matcher.compare(c1, c2)
    redirect_to show_guesses_path(id: params[:id])
  end

  def show_guesses
    redirect_to show_game_path(id: params[:id]) and return if @user.id != @game.current_player_id
    @game = Game.find(params["id"])
    @cards = Card.where(game_id: @game.id).order(position: :asc).to_ary
    @game.update_current_player
    end_game
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

  def end_game
    if @game.end_game && @game.winner_id == current_user.id
      redirect_to show_game_path(id: @game), notice: "Congratulations, you won!" and return
    elsif @game.end_game && @game.winner_id != current_user.id
      redirect_to show_game_path(id: @game), flash: {alert: "Better luck next time."} and return
    end
  end
end
