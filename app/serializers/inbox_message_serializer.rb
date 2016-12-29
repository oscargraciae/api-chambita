# == Schema Information
#
# Table name: inbox_messages
#
#  id          :integer          not null, primary key
#  message     :string
#  sender_user :integer
#  inbox_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  readit      :boolean          default(FALSE)
#

class InboxMessageSerializer < ActiveModel::Serializer
  attributes :id, :message, :readit, :created_at, :sender_name
  has_one :sender

  def sender_name
    object.sender.first_name
  end
end
