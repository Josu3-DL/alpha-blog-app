Rails.application.routes.draw do

  root "pages#home"
  get "about", to: "pages#about"

  resources :articles
  resources :users, only: [:edit, :update, :create, :new, :show, :index]
 
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  get 'logout', to: "sessions#destroy"
end
