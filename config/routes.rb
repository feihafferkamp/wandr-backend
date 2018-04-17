Rails.application.routes.draw do
  resources :users, except: [:new, :edit]
  resources :user_trips, except: [:new, :edit]
  resources :trips, except: [:new, :edit]
  resources :activities, except: [:new, :edit]
  resources :destinations, except: [:new, :edit, :destroy]
  resources :friendships, except: [:new, :edit]
  post "/friendships/update", to: "friendships#update"
  post "/friendships/cancel", to: "friendships#cancel"
  delete "/friendships/destroy", to: "friendships#destroy"

  # resources :tags, except: [:new, :edit, :destroy]

  post "/signup", to: "users#create"
  post "/login", to: "auth#create"
  get "/current_user", to: "auth#show"
end
