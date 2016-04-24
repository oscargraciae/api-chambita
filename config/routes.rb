Rails.application.routes.draw do
  #devise_for :users

  namespace "api",  defaults: {format: :json} do
    namespace "v1" do
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        member do
          put 'avatar'
          put 'password'
        end
      end
      resources :services, only: [:index, :show, :create, :update, :destroy] do
        member do
          put 'published'
        end
        collection do
          get 'search'
        end
      end
      resources :service_images, only: [:index, :create, :destroy]
      resources :locations, only: :index
      resources :authentication, only: [:create, :destroy]
      resources :me, only: :index
      resources :categories, only: :index
      resources :request_services, only: [:index, :show, :create] do 
        collection do
            get 'jobs'
          end
      end
      resources :request_message, only: [:create]
    end
  end
end