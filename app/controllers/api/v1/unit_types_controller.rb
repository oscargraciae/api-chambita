class Api::V1::UnitTypesController < BaseController
  def index
    render json: UnitType.all, satus: :ok
  end
end
