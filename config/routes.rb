Rails.application.routes.draw do
  Rails.application.routes.draw do
    namespace :api do
      namespace :v0 do
        resources :forecast, only: [:show], param: :location
      end
    end
  end  
end
