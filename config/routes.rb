Rails.application.routes.draw do
  resources :profiles
  resources :accounts
  # resources :users, only: [:show] do
  #  resources :accounts
  # end
  devise_for :users

  resources :transactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'panel#show'
end
