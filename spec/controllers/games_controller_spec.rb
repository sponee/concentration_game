require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  render_views

  before do
    @user = create(:user)
  end

  context "When logged in" do 

    it "#index shows the current user's games" do
      sign_in @user
      get :index, params: { user_id: @user.id }

      expect(response.body).to include("Hello, world! This is the games#index view.")
    end
  end

  context "When not logged in" do

    it "#index redirects to the root_url and flashes and error" do 
      sign_in nil
      get :index, params: { user_id: @user.id }
      expect(response.redirect_url).to eq(root_url)
      expect(flash["alert"]).to eq("You are not authorized to view this content.")
    end
  end
end
