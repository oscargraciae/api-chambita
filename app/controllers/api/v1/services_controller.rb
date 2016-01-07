class Api::V1::ServicesController < BaseController
  def index
    render json: {:mensaje => Service.all}, status: :ok
  end
end
