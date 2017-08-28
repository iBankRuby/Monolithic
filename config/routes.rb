Rails.application.routes.draw do
  resources :accounts, except: %i[edit] do
    resources :statistics, only: %i[index create update]
    resources :transactions, only: %i[index create] do
      patch :cancel, :confirm, :ownerapprove
      post :exchange, on: :collection
    end
    resources :invites, only: %i[index create destroy update] do
      patch :confirm, :reject
    end
    resources :management, only: %i[index destroy]
    resources :co_users, only: %i[show update]
    # resources :rules, except: %i[show destroy]
    resources :exceeding_requests, only: %i[create update destroy]
  end

  devise_for :users,
             path: '',
             controllers: { registrations: 'registrations', confirmations: 'devise/confirmations' }

  root to: 'accounts#index'
end
