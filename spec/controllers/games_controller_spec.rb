require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  render_views

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
  end
end
