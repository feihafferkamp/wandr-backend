Rails.application.routes.draw do
  resources :users, except: [:new, :edit]
  resources :user_trips, except: [:new, :edit]
  resources :trips, except: [:new, :edit]
  resources :activities, except: [:new, :edit]
  resources :destinations, except: [:new, :edit, :destroy]
  resources :friendships, only: [:create, :update]
  post "friendships/delete", to: "friendships#destroy"
  post "friendships/update", to: "friendships#update"

  # resources :tags, except: [:new, :edit, :destroy]

  post "/signup", to: "users#create"
  post "/login", to: "auth#create"
  get "/current_user", to: "auth#show"
end
