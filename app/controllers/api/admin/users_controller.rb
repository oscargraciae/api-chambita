class Api::Admin::UsersController < ApplicationController

  def index
    users = User.all.order(created_at: :desc)
    render json: users, status: :ok, each_serializer: AdminUsersSerializer
  end

  def suppliers
    suppliers = User.joins("INNER JOIN Services ON services.user_id = users.id").distinct.order(created_at: :desc)
    render json: suppliers, status: :ok, each_serializer: AdminUsersSerializer
  end

end
