Rails.application.routes.draw do
  resources :accounts
  devise_for :users

  resources :transactions
  root to: 'panel#show'
end
