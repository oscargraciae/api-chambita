class Api::Admin::ServicesController < ApplicationController
  def index
    services = Service.all.includes(:user, :sub_category, :unit_type, :packages).active.order(created_at: :desc)

    render json: services, status: :ok, each_serializer: AdminServicesSerializer
  end

  def published
    service = Service.find(params[:id])

    if params[:published] == true

      if Package.where(service_id: params[:id]).size > 0
        service.published = true
        message = "El servicio se ha activado"
      else
        message = "El servicio no tiene precio"
        service.published = false
      end

    elsif params[:published] == false
      service.published = false
      message = "El servicio se ha desactivado"
    end



    if service.save
      render json: { message: message, published: service.published }, status: 200
    else
      render json: { errors: service.errors }, status: 422
    end
  end

end
