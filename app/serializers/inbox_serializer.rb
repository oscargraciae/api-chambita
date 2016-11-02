class InboxSerializer < ActiveModel::Serializer
  attributes :id, :updated_at
  has_many :inbox_message
  has_one :sender
  has_one :recipient

  def inbox_message
    object.inbox_message.order(created_at: :desc).includes(:sender)
  end
end
