class Api::V1::NotificationController < BaseController
	before_filter :auth, only: [:index, :read, :update]

	def index
		notifications = Notification.where(user_id: @user.id).limit(5).order(created_at: :desc).includes(:user, :notified_by, :request_service)

		notification_size = Notification.where(user_id: @user.id, read: false).order(created_at: :desc).includes(:user, :notified_by, :request_service).size

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
			render json: notification.error, status: 200
		end

	end
end
