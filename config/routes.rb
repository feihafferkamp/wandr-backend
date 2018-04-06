Rails.application.routes.draw do
  resources :users, except: [:new, :edit, :destroy]
  resources :trips, except: [:new, :edit]
  resources :destinations, except: [:new, :edit, :destroy]
  resources :tags, only: [:index, :show]
  resources :auth, only: [:create]

  post '/signup', to: "users#create"
  post '/login', to: "auth#create"
  get '/current_user', to: "auth#show"
end
