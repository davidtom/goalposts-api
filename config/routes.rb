Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "static#index"

  resources :highlights, only: [:index, :show]
  resources :teams, only: [:index, :show]


end
