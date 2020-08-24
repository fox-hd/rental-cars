Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_categories
  resources :subsidiaries
  resources :car_models
  resources :cars
  resources :rentals, only: [:index, :show, :new, :create]
end
