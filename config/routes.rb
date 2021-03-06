Rails.application.routes.draw do
  resources :accounts, except: %i[edit update] do
    resources :transactions, only: %i[create]
    resources :invites, only: %i[index create destroy update]
    resources :rules, except: %i[show destroy]
  end

  devise_for :users
  root to: 'accounts#index'
end
