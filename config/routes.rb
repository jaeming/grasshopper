Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'

  scope defaults: {format:'json'}, constraints: {format:'json'} do
    resources :boards do
      resources :messages
    end
  end
end
