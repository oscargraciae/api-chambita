class Api::V1::MeController < BaseController
  before_filter :auth, only: [:index]

  def index
    me = @user
    render json: me, status: :ok
  end
end
