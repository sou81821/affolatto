Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets, only: [:index, :new, :create]
  get 'users/:id' => 'users#show'
  post 'tweets/get_position' => 'tweets#get_position'
end
