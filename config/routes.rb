Rails.application.routes.draw do
  resources :accounts, except: %i[edit update] do
    resources :transactions, only: %i[create]
    resources :invites, only: %i[index index create destroy update]
    resources :management
    resources :rules, except: %i[destroy]
  end

  resources :limits

  devise_for :users

  resources :profile

  root to: 'accounts#index'
end
