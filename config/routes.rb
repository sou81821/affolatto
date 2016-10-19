Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets, except: [:show, :edit]
  resources :users, only: [:show]
end
