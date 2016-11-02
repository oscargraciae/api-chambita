class Api::V1::ServicesController < BaseController
  before_filter :auth, only: [:create, :update, :destroy, :my_services, :show_service, :published]

  MODULE_NAME = 'service_controller'

  # METODOS PUBLICOS -> Estos metodos pueden ser consultados sin necesidad de estar autenticado.
  def index
    services = Service.search_service(params)
    render json: services, status: :ok
  end

  def search
    services = Service.search_service(params)

    # render json: services, each_serializer: ServicePublicDetailSerializer, status: :ok
    render json: services, status: :ok
  end

  def user_services
    services = Service.service_by_user_id(params[:user_id]).where(isActive: true, published: true)
    render json: services, status: :ok
  end

  def show
    ser = Service.find_by(id: params[:id], isActive: true, published: true)
    if ser

      visits = ser.visits + 1
      ser.update_attribute(:visits, visits)

      render json: ser, serializer: ServiceDetailSerializer, status: :ok
    else
      render json: { message: 'Este servicio ya no está disponible.' }, status: 404
    end
  end

  # METODOS PRIVADOR -> Estos metodos pueden ser consultados sin necesidad de estar autenticado.
  def my_services
    services = Service.service_by_user_id(@user.id)
    render json: services, each_serializer: ServicePrivateSummarySerializer, status: :ok
  end

  def show_service
    ser = Service.find_by(id: params[:id], user_id: @user.id, isActive: true)
    if ser
      render json: ser, serializer: ServicePrivateDetailSerializer, status: :ok
    else
      render json: { message: 'No tiene aceso a este servicio.' }, status: 500
    end
  end

  def create
    begin
      ser = Service.new(service_params)
      ser.published = false
      if ser.save
        render json: ser, status: 201
      else
        render json: { errors: ser.errors }, status: 422
      end
    rescue => exception
      exception_message(exception)
    end
  end

  def update
    service = Service.find(params[:id])

    if service.update(service_params)
      render json: service, status: :ok
    else
      render json: { errors: service.errors }, status: 200
    end
  end

  def published
    service = Service.find(params[:id])

    if Package.where(service_id: params[:id]).size > 0
      service.published = true
    else
      service.published = false
    end

    if service.save
      render json: { status: true, published: service.published }, status: 200
    else
      render json: { errors: service.errors }, status: 422
    end
  end

  def destroy
    service = Service.find(params[:id])
    service.isActive = false
    if service.save
      ServiceImage.delete_by_service_id(service.id)
      # Evaluation.delete_by_service_id(service.id)
      render json: { message: 'El servicio se eliminó satisfactoriamente.', delete: true }
    else
      render json: { message: 'ha ocurrido un error y el servicio no pudo ser eliminado.', delete: false }
    end
  end

  def render_service
    @service = nil
    if params[:id]
      @service = Service.find_by(id: params[:id], isActive: true, published: true)
    end

    render template: 'render_og'
  end

  private
  def exception_message(exception)
    ApiLog.create(message: exception.message, module: MODULE_NAME)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  private
  def set_service
    @ser = Service.find(params[:id])
  end

  # Parametros con permiso de entrada para registro de servicio
  def service_params
    params.permit(:name, :description, :category_id, :country, :state, :locality, :price, :sub_category_id, :user_id, :lat, :lng, :cover, :unit_type_id, :unit_max, :packages)
  end
end
