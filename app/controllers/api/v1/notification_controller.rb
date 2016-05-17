class Api::V1::NotificationController < BaseController
	before_filter :auth, only: [:index]
	
	def index
		notifications = Notification.where(user_id: @user.id)
		puts notifications.as_json
		render json: notifications, status: :ok
	end
	
end
