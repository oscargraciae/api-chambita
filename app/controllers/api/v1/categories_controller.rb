class Api::V1::CategoriesController < ApplicationController
  respond_to :json

  def index
    render json: Category.all.includes(:sub_categories), status: :ok
  end

end
