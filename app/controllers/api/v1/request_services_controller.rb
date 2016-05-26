class Api::V1::RequestServicesController < BaseController
  before_filter :auth, only: [:index, :show, :create, :jobs, :accept_job, :finish_job, :status]

  def index

    requests = RequestService.requests_by_status(@user.id, params[:status_id])
    #requests_pending = RequestService.all_pending(@user.id)
    #requests_inprocess = RequestService.all_inprogress(@user.id)

    # render json: {
    #   requests_finish: , each_serializer: RequestServiceSerializer),
    #   requests_inprocess: ActiveModel::ArraySerializer.new(requests_inprocess.page(1).per(10), each_serializer: RequestServiceSerializer),
    #   requests_pending: ActiveModel::ArraySerializer.new(requests_pending.page(1).per(10), each_serializer: RequestServiceSerializer),
    #   total_finished: requests_finish.length,
    #   total_pending: requests_pending.length,
    #   total_inprocess: requests_inprocess.length
    #   }, status: :ok

    render json: requests, status: :ok

  end

  def jobs
    #jobs = RequestService.jobs(@user.id)

    jobs = RequestService.jobs_by_status(@user.id, params[:status_id])
    #jobs_pending = RequestService.jobs_pending(@user.id)
    #jobs_inprocess = RequestService.jobs_inprocess(@user.id)

    # render json: {
    #   jobs_finished: ActiveModel::ArraySerializer.new(jobs_finished.page(1).per(10), each_serializer: RequestServiceSerializer),
    #   jobs_inprocess: ActiveModel::ArraySerializer.new(jobs_inprocess.page(1).per(10), each_serializer: RequestServiceSerializer),
    #   jobs_pending: ActiveModel::ArraySerializer.new(jobs_pending.page(1).per(10), each_serializer: RequestServiceSerializer),
    #   total_finished: jobs_finished.length,
    #   total_pending: jobs_pending.length,
    #   total_inprocess: jobs_inprocess.length
    #   }, status: :ok
    # render json: jobs, status: :ok

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
     request.fee = service.price * 0.12
     request.supplier_id = service.user_id

     if request.save
      create_notification(request, "ha solicitado el servicio", request.user.id, request.supplier.id)

      render json: request, status: :ok
    else
      render json: "Error", status: 422
    end
  end

  def accept_job
    request = RequestService.find(params[:id])
    
    if request.update_attribute(:request_status_id, REQUEST_STATUS_INPROCESS)
      
      create_notification(request, "acepto el trabajo", request.supplier.id, request.user.id)

      Order.create(request.id, ORDER_STATUS_PENDING, request.price, request.fee)

      render json: request, status: :ok
    end
  end

  def finish_job
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
