# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecast#show'
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trips, only: [:create]
      get '/book-search', to: 'book_search#show'
      resources :backgrounds, only: [:index]
    end
  end
end
