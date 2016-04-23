class Api::V1::RequestServicesController < ApplicationController
  
  def index
		requests = RequestService.all
	  	
  	render json: requests, status: :ok
  end

  def show
    request = RequestService.find(params[:id])

    render json: request, status: :ok
  end

  def create
  	request = RequestService.new(request_params)

  	if request.save
  		render json: request, status: :ok
  	else
  		render json: "Error", status: 422
  	end
  end

  def request_params
  	params.permit(:request_date, :request_time, :message, :user_id, :service_id)
  end
end
