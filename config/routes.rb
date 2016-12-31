Rails.application.routes.draw do
  devise_for :users
  
  root 'application#hello'

  resources :users do
    get '/games', to: 'games#index'
      resources :games do
    end
  end
  patch 'games/:id/match_cards',  to: 'games#match_cards', as: 'match_cards'
  get   'games/:id',              to: 'games#show',        as: 'show_game'
  get   'games/:id/show_guesses', to: 'games#show_guesses', as: 'show_guesses'
  post  'users/:id/games',        to: 'games#create', as: 'create_game'
end
