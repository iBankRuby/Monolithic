Rails.application.routes.draw do

  resources :accounts do
    resources :transactions
  end
  devise_for :users
  
  root to: 'accounts#index'
end
