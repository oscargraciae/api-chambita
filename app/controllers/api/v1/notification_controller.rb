class Api::V1::NotificationController < BaseController
	before_filter :auth, only: [:index]
	
	def index
		notifications = Notification.where(user_id: @user.id).order(created_at: :desc)
		notification_size = notifications.where(read: false).size
		
		render json: {notifications: ActiveModel::ArraySerializer.new(notifications), count: notification_size}, status: :ok
	end
	
end
