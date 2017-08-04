Rails.application.routes.draw do
  resources :accounts, except: %i[edit update] do
    resources :transactions, only: %i[create, update]
    resources :invites, only: %i[index index create destroy update]
    resources :management
    resources :co_users
    resources :rules, except: %i[destroy]
  end

  resources :limits

  devise_for :users
  root to: 'accounts#index'
end
