class Api::Admin::ReportsController < ApplicationController

  def total_users
    total_users = User.all.size
    render json: total_users, status: :ok
  end

  def total_service_by_category
    hash_total_services = Service.where(isActive: true).group(:category_id).count
    render json: hash_total_services, status: :ok
  end

  def users_by_month
    @connection = ActiveRecord::Base.connection
    services = @connection.exec_query("SELECT to_char(created_at, 'YYYY-MM') as month, count(created_at) as total_count
                          FROM users
                          GROUP BY to_char(created_at, 'YYYY-MM')
                          ORDER BY to_char(created_at, 'YYYY-MM') asc")
    render json: services, status: :ok
  end

  def services_by_month
    @connection = ActiveRecord::Base.connection
    services = @connection.exec_query("SELECT to_char(created_at, 'YYYY-MM') as month, count(created_at) as total_count
                          FROM services
                          GROUP BY to_char(created_at, 'YYYY-MM')
                          ORDER BY to_char(created_at, 'YYYY-MM') asc")
    render json: services, status: :ok
  end

end
