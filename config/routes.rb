Rails.application.routes.draw do
  resources :accounts do
    resources :schedules
    resources :messages, only: [:new, :create, :index, :show] do
      post 'send_message'
    end
  end

  post '/sms' => 'messages#receive_message'

end
