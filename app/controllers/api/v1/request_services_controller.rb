class Api::V1::RequestServicesController < ApplicationController
  
  def index
		#requests = RequestService.all

    # requests = RequestService.joins(:service).where(services: {user_id: 3})
    status_ids = params[:status]
  	requests = RequestService.where({ user_id: params[:user_id], request_status_id: status_ids }).order(created_at: :desc)
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
    request.supplier_id = service.user_id

  	if request.save
  		render json: request, status: :ok
  	else
  		render json: "Error", status: 422
  	end
  end

  def jobs
    jobs = RequestService.jobs(params)

    render json: jobs, status: :ok
  end

  def accept_job
    request = RequestService.find(params[:id])
    
    if request.update_attribute(:request_status_id, REQUEST_STATUS_INPROCESS)
      # req_status = RequestStatus.find(REQUEST_STATUS_ACEPTED)

      Order.create(request.id, 3, request.price, request.fee)

      render json: request, status: :ok
    end
  end

  def finish_job
    request = RequestService.find(params[:id])

    if params[:finish_type] == 'supplier'

      request.update_attribute(:is_finish_supplier, true)
      render json: request, status: :ok

    elsif params[:finish_type] == 'customer'

      # Cuando el cliente valida el trabajo se cambia la bandera
      request.update_attribute(:is_finish_customer, true)

      #se actualiza el estatus de la solicitud
      request.update_attribute(:request_status_id, REQUEST_STATUS_FINISH)

      puts request.id
      #Se actualia la orden de compra
      order = Order.where(request_service_id: request.id)
      puts order.as_json
      order.order_status_id = 1
      order.save
      
      # regresamos la solicitud con los campos actualizados
      render json: request, status: :ok
    else

    end

  end

  def status
    request = RequestService.find(params[:id])

    if request.update_attribute(:request_status_id, params[:status_id])
      req_status = RequestStatus.find(params[:status_id])
      render json: req_status, status: :ok
    end
  end

  def request_params
  	params.permit(:request_date, :request_time, :message, :user_id, :service_id)
  end
end
