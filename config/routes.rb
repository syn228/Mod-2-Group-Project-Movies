Rails.application.routes.draw do
  resources :casts
  resources :roles
  resources :appearances
  resources :actors
  resources :characters
  resources :movies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
