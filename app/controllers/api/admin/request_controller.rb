class Api::Admin::RequestController < ApplicationController

  def index
    if params[:request_status_id]
      requests = RequestService.where(request_status_id: params[:request_status_id]).order(created_at: :desc)
    else
      requests = RequestService.all.recent
    end

    render json: requests, status: :ok
  end

end
