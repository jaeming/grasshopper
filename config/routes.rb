Rails.application.routes.draw do

  scope defaults: {format:'json'}, constraints: {format:'json'} do
    resources :boards
    resources :users
  end

  # resources :boards
  # resources :users
  #
  # root to: 'boards#index'
end
