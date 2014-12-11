Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'


  scope defaults: {format:'json'}, constraints: {format:'json'} do
    resources :boards do
      resources :messages
    end
    match 'users', to: 'users#create', via: [:options]
    resources :users
    resources :sessions
  end
  scope :user do
    get '/current_user' => 'sessions#show_current_user'
  end
end
