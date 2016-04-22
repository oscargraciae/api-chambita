class RequestMessageSerializer < ActiveModel::Serializer
  #attributes :id, :sender, :recipient, :text
  attributes :text
  has_one :sender
  has_one :recipient
end
