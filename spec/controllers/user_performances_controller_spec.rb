require 'rails_helper'

RSpec.describe UserPerformancesController, type: :controller do
  
  before do
    @user = create(:user)
  end

  it "#leaderboard renders the user_performances#leaderboard template" do
    get :leaderboard

    expect(response).to render_template(:leaderboard)
    expect(response.status).to eq(200)
  end

  it "show renders the user_performances#show template" do
    get :show, params: {id: @user.id}

    expect(response).to render_template(:show)
    expect(response.status).to eq(200)
  end
end