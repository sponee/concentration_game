Rails.application.routes.draw do
  devise_for :users
  
  root 'application#hello'

  resources :users do
    get '/games', to: 'games#index'
  end
  resources :games do
  end
  patch 'games/:id/match_cards', to: 'games#match_cards', as: 'match_cards'
end
