class NotificationSerializer < ActiveModel::Serializer
	attributes :id, :message, :type_notification, :user_name, :service_name, :user_avatar

	#has_one :notified_by, class_name: 'User'  
	#has_one :user  
	#has_one :request_service

	def user_name
		object.notified_by.first_name
	end

	def user_avatar
		object.notified_by.avatar
	end

	def service_name
		object.request_service.service.name
	end
	
	def message
		[object.user.first_name]
		"#{object.notified_by.first_name} #{object.type_notification} #{object.request_service.service.name}"
	end
end
