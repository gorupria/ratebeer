Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  root 'breweries#index'

  resources :styles
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'

  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_frozen', on: :member
  end
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
end
