class Api::V1::PackagesController < ApplicationController

  def index
    # packages = Package.where(service_id: params[:service_id]).order(price: :desc)
    packages = Package.where(service_id: params[:service_id])
    render json: packages, active: true, status: :ok
  end

  def show
    package = Package.find(params[:id])

    if package
      render json: package, serializer: PackageDetailSerializer, status: :ok
    else
      render json: {error: "not found", message: "El paquete no se encontró"}, status: 404
    end

  end

  def create

    package = Package.new(package_params)
    package.is_principal = isPrincipal(params[:service_id])

    if package.save
        render json: package, status: :ok
    else
        render json: {error: true, message: package.errors}, status: 422
    end
  end

  def destroy
    package = Package.find(params[:id])
    package.active = false
    if package.save

      service = Service.find(package.service_id)
      if Package.where(service_id: package.service_id).size > 0
        service.published = true
      else
        service.published = false
      end
      service.save

      if service.published
          render json: {published: service.published, message: 'El paquete se eliminó satisfactoriamente.', delete: true }, status: :ok
      else
        render json: {published: service.published, message: 'Servicio desactivado. Debes por lo menos añadir un precio', delete: true }, status: :ok
      end


    else
      render json: package.errors, status: 422
    end

  end

  def package_params
    params.permit(:title, :description, :price, :unit_type_id, :unit_max, :service_id)
  end

  private
  def isPrincipal(service_id)
    packages = Package.where(service_id: service_id).size
    puts packages
    if packages === 0
      return true

    else
      return false
    end
  end
end
