Rails.application.routes.draw do
  resources :profiles
  resources :accounts
  #resources :users, only: [:show] do
  #  resources :accounts
  #end
end
