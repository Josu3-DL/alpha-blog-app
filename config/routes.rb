Rails.application.routes.draw do

  root "pages#home"
  get "about", to: "pages#about"

  resources :articles
  resources :users
 
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  get 'logout', to: "sessions#destroy"
end
