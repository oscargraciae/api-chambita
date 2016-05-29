class InboxMessageSerializer < ActiveModel::Serializer
  attributes :id, :message
  has_one :sender, serializer: UserOnlySerializer

end
