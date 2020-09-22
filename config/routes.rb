Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_categories
  resources :subsidiaries
  resources :car_models
  resources :cars
  resources :rentals, only: [:index, :show, :new, :create] do
    resources :car_rentals, only: [:new, :create]
    get 'search', on: :collection
  end
  
  resources :clients do
    get 'search', on: :collection
  end
  
  namespace :api do
    namespace :v1 do
      resources :cars, only: %i[index]
    end
  end
  
end
