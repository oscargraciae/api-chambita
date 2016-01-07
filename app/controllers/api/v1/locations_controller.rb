class Api::V1::LocationsController < BaseController
  def index
    render json: { :menaje => Location.all}, status: :ok
    
  end
end
