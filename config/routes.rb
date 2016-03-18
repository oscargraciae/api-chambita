Rails.application.routes.draw do
  #devise_for :users

  namespace "api",  defaults: {format: :json} do
    namespace "v1" do
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        member do
          put 'avatar'
        end
      end
      resources :services, only: [:index, :show, :create, :update, :destroy] do
        member do
          put 'published'
        end
      end
      resources :service_images, only: [:index, :create]
      resources :locations, only: :index
      resources :authentication, only: [:create, :destroy]
      resources :me, only: :index
      resources :categories, only: :index
    end
  end
end
