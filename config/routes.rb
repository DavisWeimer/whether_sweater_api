Rails.application.routes.draw do
  Rails.application.routes.draw do
    namespace :api do
      namespace :v0 do
        resources :forecast, only: [:show], param: :location
        resources :users, only: [:create]
      end
    end
  end  
end
