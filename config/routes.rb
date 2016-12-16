Rails.application.routes.draw do
  devise_for :users
  
  root 'application#hello'
  resources :games do
  end
end
