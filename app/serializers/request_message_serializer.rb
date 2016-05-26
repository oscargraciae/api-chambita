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

class RequestMessageSerializer < ActiveModel::Serializer
  #attributes :id, :sender, :recipient, :text
  attributes :text, :created_at
  has_one :sender
  has_one :recipient
end
