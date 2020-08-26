Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_categories
  resources :subsidiaries
  resources :car_models
  resources :cars
  get 'rentals/search', to: 'rentals#search'
  resources :rentals, only: [:index, :show, :new, :create]
  get 'clients/search', to: 'clients#search'
  resources :clients
  
  
end
