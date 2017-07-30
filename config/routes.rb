Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Static pages
  get "/", to: "static#index", as: "home"

  # Sign up, log in and log out
  get "/signup", to: "users#new", as: "signup"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Highlights Data Pipeline
  # JSON Data:
  get "highlights/pendingJSON", to: "highlights#pendingJSON"
  # View:
  get "highlights/pending", to: "highlights#pending_edit"
  post "highlights/pending", to: "highlights#pending_update"

  # Model-related resources
  resources :users, except: [:new]
  resources :highlights, only: [:index, :show, :edit, :update]
  resources :teams, only: [:index, :show]

end
