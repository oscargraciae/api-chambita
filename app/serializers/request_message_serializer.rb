class RequestMessageSerializer < ActiveModel::Serializer
  #attributes :id, :sender, :recipient, :text
  attributes :text, :created_at
  has_one :sender
  has_one :recipient
end
