class Api::Admin::RequestController < ApplicationController
  def index
    requests = RequestService.all.recent
    render json: requests, status: :ok
  end
end
