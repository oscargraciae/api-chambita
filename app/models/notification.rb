class Notification < ActiveRecord::Base
	belongs_to :notified_by, class_name: 'User'  
	belongs_to :user  
	belongs_to :request_service

	#validates :user_id, :notified_by_id, :request_service_id, :identifier, :type, presence: true

	
  
end
