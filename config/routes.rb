Rails.application.routes.draw do
  devise_for :users
  
  root 'application#hello'

  resources :users do
    get '/games', to: 'games#index'
    post '/games/new', to: 'games#create'
      resources :games do
    end
  end

  get   'leaderboard',            to: 'user_performances#leaderboard', as: 'show_leaderboard'
  get   'user_performances/:id',  to: 'user_performances#show', as: 'show_performance'
  patch 'games/:id/match_cards',  to: 'games#match_cards',      as: 'match_cards'
  get   'games/:id',              to: 'games#show',             as: 'show_game'
  get   'games/:id/show_guesses', to: 'games#show_guesses',     as: 'show_guesses'
  post  'users/:id/games',        to: 'games#create',           as: 'create_game'
end
