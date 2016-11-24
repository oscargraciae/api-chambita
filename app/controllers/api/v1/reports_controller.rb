class Api::V1::ReportsController < BaseController
    before_filter :auth, only: [:sales, :total_sales]

    def sales
        #pending = RequestService.where(supplier_id: @user.id, request_status_id: REQUEST_STATUS_PENDING).sum(:subtotal)
        # pending = RequestService.where('supplier_id = ? AND (request_status_id = ? OR request_status_id = ? )', @user.id, 1, 2).sum(:subtotal)
        # sold = RequestService.where('supplier_id = ? AND request_status_id = ? ', @user.id, 3).sum(:subtotal)
        
        pending = Order.joins("INNER JOIN request_services r on orders.request_service_id = r.id").where('r.supplier_id = ? AND order_status_id = ?', @user.id, 3).sum(:subtotal)
        sold = Order.joins("INNER JOIN request_services r on orders.request_service_id = r.id").where('r.supplier_id = ? AND order_status_id = ?', @user.id, 1).sum(:subtotal)
        total = sold + pending
        render json: {pending: pending, sold: sold, total: total}, status: :ok
    end

    def total_sales
        total = Service.select("SUM(services.visits) AS visits, SUM(services.total_jobs) AS total_jobs").where(user_id: @user.id, isActive: true)[0]

        render json: {visits: total.visits, jobs: total.total_jobs} , status: :ok
    end
end
