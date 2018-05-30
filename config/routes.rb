Rails.application.routes.draw do
  resources :collections
  resources :users
  resources :casts
  resources :roles
  resources :appearances
  resources :actors
  resources :characters
  resources :movies
  resources :generals, only: [:index]

  get '/', to: 'generals#home', as: "home"
  get '/search', to: 'generals#search', as: "search"
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  post "sessions", to: "sessions#create", as: "sessions"
  post "logout", to: "sessions#destroy", as: "logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
