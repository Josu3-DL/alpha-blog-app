Rails.application.routes.draw do

  root "pages#home"
  get "about", to: "pages#about"

  resources :articles
  resources :users, only: [:edit, :update, :create, :new, :show, :index]
 
end
