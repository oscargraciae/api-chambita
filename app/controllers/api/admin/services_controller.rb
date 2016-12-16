class Api::Admin::ServicesController < ApplicationController
  def index
    services = Service.all.includes(:user, :sub_category, :unit_type, :packages).active.order(created_at: :desc)

    render json: services, status: :ok, each_serializer: AdminServicesSerializer
  end
end
