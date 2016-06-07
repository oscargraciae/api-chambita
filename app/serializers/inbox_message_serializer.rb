class InboxMessageSerializer < ActiveModel::Serializer
  attributes :id, :message, :readit, :created_at
  has_one :sender, serializer: UserOnlySerializer

end
