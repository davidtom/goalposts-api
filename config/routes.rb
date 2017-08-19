Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :highlights, only: [:index]

      get "/highlights/search", to: "highlights#search"
      # TODO: refactor this to a search controller! index action, highlights is just a param

      # Authentication
      post "/signup", to: "users#create"
      post "/login", to: "auth#create"
      get "/auth", to: "auth#show" #TODO: auth#show

    end
  end

end
