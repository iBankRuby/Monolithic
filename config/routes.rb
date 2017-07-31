Rails.application.routes.draw do
  resources :invites, only: %i[index create destroy update]

  resources :accounts, except: %i[edit update] do
    resources :transactions, only: %i[create]
  end

  devise_for :users
  root to: 'accounts#index'
end
