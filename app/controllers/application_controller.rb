class ApplicationController < ActionController::Base

    # rescue_from ActiveRecord::RecordNotFound do |e|
    #     ApiLog.create(message: e.message, module: "application_controller")
    #     render json: { error: e.message }, status: :not_found
    # end
end
