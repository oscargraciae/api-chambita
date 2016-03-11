class Api::V1::CategoriesController < ApplicationController
  respond_to :json
  
  def index
    render json: Category.all, status: :ok
  end
end
