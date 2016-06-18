class InboxSerializer < ActiveModel::Serializer
  attributes :id
  has_many :inbox_message
  has_one :sender, serializer: UserShortSerializer
  has_one :recipient, serializer: UserShortSerializer

  def inbox_message
  	object.inbox_message.order(created_at: :desc).includes(:sender)
  end
  
end
