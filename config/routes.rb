Rails.application.routes.draw do
  #devise_for :users

  namespace "api",  defaults: {format: :json} do
    namespace "v1" do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :services, only: [:index, :show, :create, :update, :destroy]
      resources :locations, only: :index
      resources :authentication, only: [:create, :destroy]
      resources :me, only: :index
      resources :categories, only: :index
    end
  end
end
