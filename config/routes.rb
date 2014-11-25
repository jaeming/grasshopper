Rails.application.routes.draw do

  scope defaults: {format:'json'}, constraints: {format:'json'} do
    resources :boards do
      resources :messages
    end
  end


end
