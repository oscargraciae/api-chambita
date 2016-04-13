class Api::V1::ServicesController < BaseController

  before_filter :auth, only: [:create, :update, :destroy]


  def index
    services = Service.all
    puts services
    render json: services, status: :ok
  end

  def search
    query = params[:q]
    #query = params[:q]
    
    services = Service.search_service(params)

    #location = Geocoder.search(params[:location])[0]
    
    #lat = location.coordinates[0]
    #lng = location.coordinates[1]

    #services = Service.where(["lower(name) LIKE ? ", "%#{query.downcase}%"])
    #services = services.joins(:user).near([lat, lng], 100*0.62)

    render json: services, status: :ok  

  end

  def show
    ser = Service.find(params[:id])

    render json: ser, status: :ok
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
    # puts service_params[:publish]
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
