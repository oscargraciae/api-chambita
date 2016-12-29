# == Schema Information
#
# Table name: inboxes
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class InboxSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :created_at
  has_many :inbox_message
  has_one :sender
  has_one :recipient

  def inbox_message
    object.inbox_message.order(created_at: :desc).includes(:sender)
  end
end
