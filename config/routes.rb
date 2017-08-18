Rails.application.routes.draw do
  resources :accounts, except: %i[edit] do
    resources :statistics, only: %i[index create update]
    resources :transactions, only: %i[index create] do
      patch :cancel
      patch :confirm
      patch :ownerapprove
    end
    resources :invites, only: %i[index create destroy update]
    resources :management
    resources :co_users
    resources :rules, except: %i[show destroy]
    resources :exceeding_requests, only: %i[create update destroy]
  end

  #devise_scope :user do
	#  get '/home', to: 'devise/home#new'
  #end

  as :user do
      match '/user/confirmation' => 'users/confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :limits

  resources :profile

  root to: 'accounts#index'
end
