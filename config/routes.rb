Rails.application.routes.draw do
  resources :accounts, except: %i[edit update] do
    resources :transactions, only: %i[create]
    resources :invites, only: %i[show create destroy update]
    resources :management
    resources :rules, except: %i[show destroy]
  end

  devise_for :users

  resources :profile
  
  root to: 'accounts#index'
end
