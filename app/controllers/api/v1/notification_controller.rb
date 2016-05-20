class Api::V1::NotificationController < BaseController
	before_filter :auth, only: [:index, :read]
	
	def index
		notifications = Notification.where(user_id: @user.id).order(created_at: :desc)
		notification_size = notifications.where(read: false).size
		
		render json: {notifications: ActiveModel::ArraySerializer.new(notifications), count: notification_size}, status: :ok
	end
	
	def read
		notifications = Notification.where(user_id: @user.id).update_all(:read => true)

	 	head 200
	end

	def update
		notification = Notification.find(params[:id])
		notification.read = true

		if notification.save
			render json: notification, status: :ok
		else
			render json: notification.error, status: 500
		end

	end
end
