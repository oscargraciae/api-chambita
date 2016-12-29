class Api::Admin::OrdersController < ApplicationController

  # def index
  #   if params[:order_status_id]
  #     orders = Order.where(order_status_id: params[:order_status_id]).order(created_at: :desc)
  #   else
  #     orders = Order.all
  #   end
  #
  #   render json: orders, status: :ok, each_serializer: AdminOrdersSerializer
  # end

  def index
    if params[:order_status_id]
      requests = RequestService.joins("INNER JOIN orders ON orders.request_service_id = request_services.id").where("orders.order_status_id = #{params[:order_status_id]}").order(created_at: :desc)
    else
      requests = RequestService.all.recent
    end

    render json: requests, status: :ok
  end

  def pay
    order = Order.find_by(request_service_id: params[:id])
    puts order.as_json
    if order.update_attribute(:order_status_id, params[:status_id])
      render json: {message: "Orden pagada"}, status: 200
    else
      render json: {message: "Ocurrió un error."}, status: 500
    end
  end

end
