Rails.application.routes.draw do
  get 'styles/index'
  get 'styles/show'
  get 'places/index'
  get 'places/search'

  resources :memberships
  resources :beer_clubs
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  root 'breweries#index'

  resources :styles
  resources :places, only: [:index, :show]
  # get 'places', to: 'places#index'
  post 'places', to: 'places#search'

  resources :beers
  resources :breweries
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to: 'ratings#new'
  # post 'ratings', to: 'ratings#create'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
