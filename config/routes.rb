Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :accounts
  end
end
