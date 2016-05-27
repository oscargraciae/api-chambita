class Api::V1::ServicesController < BaseController

  before_filter :auth, only: [:create, :update, :destroy, :my_services, :show_service]

  def index

    if params[:lat] && params[:lng]
      services = Service.all_services(params[:lat], params[:lng])
    else
      # colocamos una ubicacion default, en caso de no enviar parametros de latitud y longitud
      location = Geocoder.search("Monterrey, Nuevo León, México")[0]      
      lat = location.coordinates[0]
      lng = location.coordinates[1]
      
      services = Service.all_services(lat, lng)
    end

    render json: services, status: :ok
  end

  def search
    services = Service.search_service(params)
    render json: services, status: :ok
  end

  def my_services
    services = Service.service_by_user_id(@user.id)
    render json: services, status: :ok
  end

  def show_service
    ser = Service.find_by(id: params[:id], user_id: @user.id)
    render json: ser, status: :ok
  end

  def show
    ser = Service.find(params[:id])
    render json: ser, serializer: ServiceDetailSerializer, status: :ok
  end

  def create
    ser = Service.new(service_params)
    if ser.save
      render json: ser, status: 201
    else
      render json: {errors: ser.errors}, status: 422
    end
  end

  def update
    service = Service.find(params[:id])

    if service.update(service_params)
        render json: service, status: :ok
    else
        render json: {errors: service.errors}, status: 422
    end
  end

  def published
    service = Service.find(params[:id])
    
    if service.update_attribute(:published, params[:publish])
      render json: {status: true, published: service.published}, status: 200
    else
      render json: {errors: service.errors}, status: 422
    end
  end

  def destroy
    service = Service.find(params[:id])
    service.destroy
    head 204
  end

  private 
  def set_service
    @ser = Service.find(params[:id])
  end

  # Parametros con permiso de entrada para registro de servicio
  def service_params
    params.permit(:name, :description, :category_id, :country, :state, :locality, :price, :sub_category_id, :user_id, :lat, :lng, :cover)
  end

end
