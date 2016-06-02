class InboxMessageSerializer < ActiveModel::Serializer
  attributes :id, :message, :readit
  has_one :sender, serializer: UserOnlySerializer

end
