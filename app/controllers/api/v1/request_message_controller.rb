class Api::V1::RequestMessageController < BaseController
  before_filter :auth, only: [:index, :create]

  def index
    messages = RequestMessage.get_by_request_id(params[:request_id])

    # messages = RequestMessage.where(request_service_id: params[:request_id])
    render json: messages, status: :ok
  end

  def create
    m = RequestMessage.new(message_params)
    if m.save
      messages = RequestMessage.where(request_service_id: m.request_service_id).order(created_at: :desc)
      render json: messages, status: :ok
    else
      render json: m.error, status: 422
    end
  end

  def message_params
    params.permit(:sender_id, :recipient_id, :text, :request_service_id)
  end
end
