Rails.application.routes.draw do
  root 'sessions#index'
  get '/login', to: 'sessions#new'
  get '/logup', to: 'users#new'
  get '/logout', to: 'sessions#destroy'

  resources :locations
  resources :reviews
  resources :outings
  resources :users
  resources :plans
  resources :organizations
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
