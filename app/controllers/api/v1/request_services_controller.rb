class Api::V1::RequestServicesController < ApplicationController
  
  def index
		#requests = RequestService.all

    requests = RequestService.joins(:service).where(services: {user_id: 3})
	  	
  	render json: requests, status: :ok
  end

  def show
    request = RequestService.find(params[:id])

    render json: request, status: :ok
  end

  def create
  	request = RequestService.new(request_params)

    service = Service.find(request.service_id)

    request.price = service.price
    request.fee = service.price * 0.12
    
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
