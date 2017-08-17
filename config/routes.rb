Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :highlights, only: [:index]

      get "/highlights/search", to: "highlights#search"

      # Authentication
      post "/signup", to: "users#create"
      post "/login", to: "auth#create"
      get "/current_user", to: "users#current_user"

    end
  end

end
