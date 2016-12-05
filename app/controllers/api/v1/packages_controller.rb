class Api::V1::PackagesController < ApplicationController

  def index
    render json: Package.where(service_id: params[:service_id], active: true), status: :ok
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
      render json: { message: 'El paquete se eliminó satisfactoriamente.', delete: true }, status: :ok
    else
      render json: package.errors, status: 422
    end

  end

  def package_params
    params.permit(:description, :price, :unit_type_id, :unit_max, :service_id)
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
