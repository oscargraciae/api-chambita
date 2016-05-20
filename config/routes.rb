Rails.application.routes.draw do
  #devise_for :users

  namespace "api",  defaults: {format: :json} do
    namespace "v1" do
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        member do
          put 'avatar'
          put 'password'
          get 'me_show'
        end
        collection do 
            post 'prueba'
          end
      end
      resources :services, only: [:index, :show, :create, :update, :destroy] do
        resources :evaluations, only: [:index, :create]
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
        member do
          put 'status'
          put 'accept_job'
          put 'finish_job'
        end
        collection do
          get 'jobs'
        end
      end
      resources :request_message, only: [:create]
      resources :credit_cards, except: [:new, :edit]
      resources :notification, only: [:index] do
        collection do
          get 'read'
        end
      end
    end
  end
end