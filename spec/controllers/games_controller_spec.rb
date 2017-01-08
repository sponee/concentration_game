require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  before do
    @user = create(:user)
    @game = @user.games.create(player_one_id: @user.id, player_two_id: 2, current_player_id: @user.id)
  end

  context "When logged in" do 

    it "#index shows the current user's games" do
      sign_in @user
      get :index, params: { user_id: @user.id }

      expect(response).to render_template(:index)
      expect(response.status).to eq(200)
    end

    it "#show renders a template for the given game" do
      sign_in @user
      get :show, params: {user_id: @user.id, id: @game.id}

      expect(response).to render_template(:show)
      expect(response.status).to eq(200)
    end

    it "#new renders the games#new template" do
      sign_in @user
      get :new, params: {user_id: @user.id}

      expect(response).to render_template(:new)
    end

    describe "#match_cards" do
      before do
        sign_in @user
        @c1 = @game.cards.first
        @c2 = @game.cards.second
      end

      context "with 2 objects in the card_ids array" do
        it "calls Matcher.compare on the objects in the card_ids array" do
          expect(Matcher).to receive(:compare).with(@c1,@c2)

          get :match_cards, params: {user_id: @user.id, id: @game.id, card_ids: [@c1,@c2]}
        end

        it "redirects to the show_guesses_url" do
          get :match_cards, params: {user_id: @user.id, id: @game.id, card_ids: [@c1,@c2]}
          expect(response.redirect_url).to eq(show_guesses_url(id: @game.id))
        end
      end

      context "with less than 2 objects in the card_ids array" do
        it "redirects to the show_game url and flashes an error" do
          get :match_cards, params: {user_id: @user.id, id: @game.id, card_ids: []}

          expect(response.redirect_url).to eq(show_game_url(@game))
          expect(flash["alert"]).to include("Please select two cards")
        end
      end

      context "with more than 2 objects in the card_ids array" do 
        it "redirects to the show_game url and flashes an error" do
          get :match_cards, params: {user_id: @user.id, id: @game.id, card_ids: [1,2,3]}

          expect(response.redirect_url).to eq(show_game_url(@game))
          expect(flash["alert"]).to include("Please select two cards")
        end
      end
    end
  end

  context "When not logged in" do

    it "#index redirects to the root_url and flashes and error" do 
      sign_in nil
      get :index, params: { user_id: @user.id }

      expect(response.status).to eq(302)
      expect(response.redirect_url).to eq(root_url)
      expect(flash["alert"]).to eq("You are not authorized to view this content.")
    end

    it "#show redirects to the root_url and flashes an error" do
      sign_in nil
      get :show, params: {user_id: rand(1..1000), id: @game.id}

      expect(response.status).to eq(302)
      expect(response.redirect_url).to eq(root_url)
      expect(flash["alert"]).to eq("You are not playing this game.")
    end

    it "#new redirects to the root_url and flashes an error" do
      sign_in nil
      get :new, params: {user_id: @user.id}

      expect(response.status).to eq(302)
      expect(response.redirect_url).to eq(root_url)
      expect(flash["alert"]).to eq("You are not authorized to view this content.")
    end
  end
end
