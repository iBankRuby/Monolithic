Rails.application.routes.draw do

  resources :accounts, except: %i[edit update] do
    resources :transactions
  end

  resources :transactions, only: [:index]

  devise_for :users
  root to: 'accounts#index'
end
