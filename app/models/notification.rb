# == Schema Information
#
# Table name: notifications
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  notified_by_id     :integer
#  request_service_id :integer
#  identifier         :integer
#  type_notification  :string
#  read               :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Notification < ActiveRecord::Base
	belongs_to :notified_by, class_name: 'User'  
	belongs_to :user  
	belongs_to :request_service
	
	#validates :user_id, :notified_by_id, :request_service_id, :identifier, :type, presence: true

	
  
end
