Rails.application.routes.draw do
  root 'sessions#index'

  resources :locations
  resources :reviews
  resources :outings
  resources :users
  resources :plans
  resources :organizations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
