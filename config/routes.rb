Rails.application.routes.draw do

  resources :accounts do
    resources :transactions
  end
  # resources :users, only: [:show] do

  #resources :transactions, only: [:index]

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'accounts#index'
end
