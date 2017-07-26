Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "static#index", as: "home"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/signup", to: "users#new", as: "signup"

  resources :users, except: [:new]
  resources :highlights, only: [:index, :show]
  resources :teams, only: [:index, :show]


end
