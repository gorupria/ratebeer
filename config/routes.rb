Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  root 'breweries#index'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
  resources :styles
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'
  match 'auth/:provider/callback', to: 'sessions#create_oauth', via: [:get, :post]

  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_frozen', on: :member
  end
  resources :memberships do
    post 'confirm_membership', on: :member
  end
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
end
