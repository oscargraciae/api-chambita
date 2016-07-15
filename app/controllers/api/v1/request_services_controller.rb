class Api::V1::RequestServicesController < BaseController
  before_filter :auth, only: [:index, :show, :create, :jobs, :accept, :finish, :status, :cancel]

  def index
    requests = []

    if params[:status_id] === '3'
      requests = RequestService.request_history(@user.id)
    else
      requests = RequestService.requests_by_status(@user.id, params[:status_id])
    end

    render json: requests, status: :ok
  end




  def jobs
    jobs = []

    if params[:status_id] === '3'
      jobs = RequestService.jobs_history(@user.id, params[:status_id])
    else
      jobs = RequestService.jobs_by_status(@user.id, params[:status_id])
    end

    render json: jobs, status: :ok
  end

  def show
    request = RequestService.find(params[:id])
    render json: request, status: :ok
  end

  def create
     request = RequestService.new(request_params)

     card = CreditCard.find(params[:card_id])
     service = Service.find(request.service_id)

     request.price = service.price
     #request.fee = service.price * CHAMBITA_FEED
     request.fee = calculate_fee(service.price)
     request.total = request.price + request.fee
     request.supplier_id = service.user_id
     request.token_card = card.token

     if request.save
      create_notification(request, "ha solicitado el servicio", request.user.id, request.supplier.id)

      render json: request, status: :ok
    else
      render json: "Error", status: 422
    end
  end

  def accept
    @request = RequestService.joins(:service).find(params[:id])

    payment_conekta()

    if @message_error
      create_notification(@request, @message_error.message_to_purchaser, @request.supplier.id, @request.user.id)

      render json: @message_error, status: 500
    else

      if @request.update_attribute(:request_status_id, REQUEST_STATUS_INPROCESS)
        create_notification(@request, "acepto el trabajo", @request.supplier.id, @request.user.id)
        Order.create(@request.id, ORDER_STATUS_PAID, @request.price, @request.fee)
        render json: @request, status: :ok
      end

    end
  end

  def finish
    request = RequestService.find(params[:id])

    if params[:finish_type] == 'supplier'
      request = finish_supplier(request)
    elsif params[:finish_type] == 'customer'
      request = finish_customer(request)
    else
      puts "Ha ocurrido un error."
    end

    render json: request, status: :ok
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

    user_id_cancel = Integer(params[:user_id])
    user_id_notifier = 0

    if user_id_cancel == request.supplier.id
      puts "notificar a usuario"
      user_id_notifier = request.user.id
    else
      puts "notificar a proveedor"
      user_id_notifier = request.supplier.id
    end

    if request.update_attribute(:request_status_id, REQUEST_STATUS_CANCELED)
      puts "Cancelado!"
      create_notification(request, "canceló el trabajo", user_id_cancel, user_id_notifier)
      render json: request, status: :ok
    else
      render json: {error: "Ocurrio un error."}, status: 500
    end
  end

  def request_params
  	params.permit(:request_date, :request_time, :message, :user_id, :service_id)
  end

  private
  def finish_customer(request)
    create_notification(request, "aprobó el trabajo", request.user.id, request.supplier.id)

    request.update_attributes(:is_finish_customer => true, :request_status_id => REQUEST_STATUS_FINISH)

    order = Order.find_by(request_service_id: request.id)
    order.update_attribute(:order_status_id, ORDER_STATUS_PAID)

    request_size = RequestService.where({service_id: request.service_id, request_status_id: REQUEST_STATUS_FINISH}).size
    s = Service.find(request.service_id)
    s.update_attribute(:total_jobs, request_size)

    request
  end

  private
  def finish_supplier(request)
    create_notification(request, "ha terminado", request.supplier.id, request.user.id)
    request.update_attribute(:is_finish_supplier, true)
    request
  end

  private
  def payment_conekta()
    begin
      @charge = Conekta::Charge.create({
        "amount"=> (@request.total * 100).to_i,
        "currency"=> "MXN",
        "description"=>  @request.message,
        "reference_id"=> @request.id,
        "card"=> @request.token_card,
        "details"=> {
          "name"=> @user.first_name,
          "phone"=> "8182002386",
          "email"=> @user.email,
          "line_items"=> [{
            "name"=> @request.service.name,
            "description"=> @request.service.description,
            "unit_price"=> (@request.price * 100).to_i,
            "quantity"=> 1
          },
          {
            "name"=> "Comision chambita",
            "description"=> "Cobro por uso de plataforma",
            "unit_price"=> (@request.fee * 100).to_i,
            "quantity"=> 1
          }]
        }
      })
    rescue Conekta::ParameterValidationError => e
      @message_error = e
      #render json: @message_error, status: 422
      #alguno de los parámetros fueron inválidos
    rescue Conekta::ProcessingError => e
      @message_error = e
      #render json: @message_error, status: 422
      #la tarjeta no pudo ser procesada
    rescue Conekta::Error => e
      #un error ocurrió que no sucede en el flujo normal de cobros como por ejemplo un auth_key incorrecto
    end
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

  private
  def calculate_fee(price)
    fee = 0
    amex = 0.045
    visa_mastercard = 0.029

    if price < 2000
      feed_percent = 0.09 + visa_mastercard
      fee = price * feed_percent
    elsif price > 2001 && price < 5000
      feed_percent = 0.07 + visa_mastercard
      fee = price * feed_percent
    elsif price > 5001
      feed_percent = 0.05 + visa_mastercard
      fee = price * feed_percent
    else
      puts "Error al calcular comision"
    end

    fee
  end

end
