class Api::V1::RequestServicesController < BaseController
  before_filter :auth, only: [:index, :show, :create, :jobs, :accept, :finish, :status, :cancel]

  def index
    requests = RequestService.requests_by_status(@user.id, params[:status_id])
    render json: requests, status: :ok
  end

  def jobs
    jobs = RequestService.jobs_by_status(@user.id, params[:status_id])
    render json: jobs, status: :ok
  end

  def show
      request = RequestService.find(params[:id])
      render json: request, status: :ok
  end

  def create
     request = RequestService.new(request_params)

     service = Service.find(request.service_id)
     request.price = service.price
     request.fee = service.price * CHAMBITA_FEED
     request.supplier_id = service.user_id

     if request.save
      create_notification(request, "ha solicitado el servicio", request.user.id, request.supplier.id)

      render json: request, status: :ok
    else
      render json: "Error", status: 422
    end
  end

  def accept
    request = RequestService.find(params[:id])

    if request.update_attribute(:request_status_id, REQUEST_STATUS_INPROCESS)

      create_notification(request, "acepto el trabajo", request.supplier.id, request.user.id)

      Order.create(request.id, ORDER_STATUS_PENDING, request.price, request.fee)

      render json: request, status: :ok
    end
  end

  def finish
    request = RequestService.find(params[:id])

    if params[:finish_type] == 'supplier'

      create_notification(request, "ha terminado", request.supplier.id, request.user.id)

      request.update_attribute(:is_finish_supplier, true)
      render json: request, status: :ok

    elsif params[:finish_type] == 'customer'

      create_notification(request, "aprobó el trabajo", request.user.id, request.supplier.id)

      # Cuando el cliente valida el trabajo se cambia la bandera
      request.update_attribute(:is_finish_customer, true)

      #se actualiza el estatus de la solicitud
      request.update_attribute(:request_status_id, REQUEST_STATUS_FINISH)

      #Se actualia la orden de compra
      order = Order.find_by(request_service_id: request.id)
      #order = Order.find_by(request_service_id: 47)
      order.order_status_id = ORDER_STATUS_PAID
      order.save

      request_size = RequestService.where({service_id: request.service_id, request_status_id: REQUEST_STATUS_FINISH}).size
      s = Service.find(request.service_id)
      s.update_attribute(:total_jobs, request_size)

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

  def cancel
    request = RequestService.find(params[:id])
    if request.update_attribute(:request_status_id, REQUEST_STATUS_CANCELED)
      render json: request, status: :ok
    else
      rener json: {error: "Ocurrio un error."}, status: 500
    end
  end

  def request_params
  	params.permit(:request_date, :request_time, :message, :user_id, :service_id)
  end

  private
  def create_notification(request, message, from, to)
    puts request.as_json
    Notification.create(user_id: to,
      notified_by_id: from,
      request_service_id: request.id,
      identifier: request.id,
      type_notification: message,
      read: false)
  end

end
