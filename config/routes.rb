Rails.application.routes.draw do
  #devise_for :users

 # namespace "api",  defaults: {format: :json}, constraints: { subdomain: 'api' }, path: '/api' do  #Servidor
  namespace "api",  defaults: {format: :json} do #local
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
          get 'show_service'
          put 'published'
        end
        collection do
          get 'search'
          get 'my_services'
          get 'user_services'
        end
      end
      resources :service_images, only: [:index, :create, :destroy]
      resources :locations, only: :index
      resources :authentication, only: [:create, :destroy] do
        collection do
          post 'facebook'
        end
      end
      resources :me, only: :index
      resources :categories, only: :index
      resources :request_services, only: [:index, :show, :create] do
        member do
          get 'cancel'
          put 'accept'
          put 'finish'
        end
        collection do
          get 'jobs'
        end
      end
      resources :request_message, only: [:index, :create]
      resources :credit_cards, except: [:new, :edit] do
        collection do
          get 'my_cards'
        end
      end
      resources :inbox, only: [:index, :create] do
        collection do
          get 'all_messages'
        end
      end
      resources :notification, only: [:index] do
        collection do
          get 'read'
        end
      end
    end
  end
end
