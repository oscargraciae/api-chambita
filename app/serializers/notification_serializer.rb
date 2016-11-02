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

class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :message, :type_notification, :user_name, :service_name, :user_avatar, :request_id, :read

  # has_one :notified_by, class_name: 'User'
  # has_one :user
  # has_one :request_service

  def request_service
    object.request_service.includes(:service)
  end

  def user_name
    object.notified_by.first_name
  end

  def user_avatar
    object.notified_by.avatar
  end

  def service_name
    object.request_service.service.name
  end

  def request_id
    object.request_service.id
  end

  def message
    [object.user.first_name]
    "#{object.notified_by.first_name} #{object.type_notification}"
  end
  # #{object.request_service.service.name}
end
