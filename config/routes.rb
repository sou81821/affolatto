Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'tweets#index'
  resources :tweets, except: [:show, :edit]
  resources :users, only: [:show]
end
