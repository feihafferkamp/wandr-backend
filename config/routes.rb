Rails.application.routes.draw do
  resources :users, except: [:new, :edit]
  resources :trips, except: [:new, :edit]
  resources :destinations, except: [:new, :edit, :destroy]
  resources :activities, except: [:new, :edit]
  # resources :tags, except: [:new, :edit, :destroy]

  post '/signup', to: "users#create"
  post '/login', to: "auth#create"
  get '/current_user', to: "auth#show"
end
