Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :highlights, only: [:index]
    end
  end

  get "/api/v1/highlights/search", to: "api/v1/highlights#search"

  # Backend Auth
  post "/api/v1/users/signup", to: "api/v1/users#create"
  # post "/api/v1/auth/login", to: "api/v1/auth#"
end
