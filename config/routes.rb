Rails.application.routes.draw do

  resources :accounts do
    resources :transactions
  end
  devise_for :users

  resources :profile
  
  root to: 'accounts#index'
end
