# == Schema Information
#
# Table name: request_messages
#
#  id                 :integer          not null, primary key
#  text               :text
#  sender_id          :integer
#  recipient_id       :integer
#  request_service_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RequestMessage < ActiveRecord::Base
  belongs_to :recipient, class_name: 'User', inverse_of: :received_messages
  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages

  scope :add_includes, -> { includes(:sender, :recipient).order created_at: :desc }
  # scope :add_include, -> { includes(:category, :user, :sub_category) }

  def self.get_by_request_id(request_id)
    RequestMessage.where(request_service_id: request_id).add_includes
  end
end
