Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'


  scope defaults: {format:'json'}, constraints: {format:'json'} do
    resources :boards do
      resources :messages
    end
    resources :users
    resources :sessions
    get 'search' => 'search#index', as: :search
  end

  scope :user do
    get '/current_user' => 'users#show_current_user'
    get 'sign_out' => 'users#sign_out', as: :sign_out
    post 'sign_in' => 'users#sign_in', as: :sign_in
  end

end
