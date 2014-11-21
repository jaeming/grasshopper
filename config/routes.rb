Rails.application.routes.draw do

  scope format: true, defaults: {format:'json'}, constraints: {format:'json'} do
    resources :boards
  end

  resources :boards
  root to: 'boards#index'
end
