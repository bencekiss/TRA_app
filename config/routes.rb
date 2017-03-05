Rails.application.routes.draw do

  root 'account_sessions#new'
  resources :accounts do
    resources :confirmations, only: [:new, :create]
    resources :schedules
    resources :messages, only: [:new, :create, :index, :show] do
      post 'send_message'
    end
  end
  resources :account_sessions, only: %i(new create destroy)
  get 'login' => 'account_sessions#new', :as => :login
  post 'logout' => 'account_sessions#destroy', :as => :logout
  get 'accounts/:account_id/account_setup' => 'accounts#account_setup', :as => :account_setup


  post '/sms' => 'schedules#receive'

end
