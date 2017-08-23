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

  #devise_scope :user do
	#  get '/home', to: 'devise/home#new'
  #end

  as :user do
      match '/user/confirmation' => 'users/confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, path: '', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :limits
  resources :profile

  root to: 'accounts#index'
end
