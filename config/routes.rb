Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecast#show'
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trips, only: [:create]
      get '/book-search', to: 'book_search#show'
    end
  end
end  

