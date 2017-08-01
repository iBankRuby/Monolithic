Rails.application.routes.draw do
  resources :invites, only: %i[index create destroy]

  resources :accounts, except: %i[edit update] do
    resources :transactions, only: %i[create]
  end

  devise_for :users

  resources :profile
  
  root to: 'accounts#index'
end
