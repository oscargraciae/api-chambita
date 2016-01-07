class ServiceSerializer < ActiveModel::Serializer
  # has_one :user
  attributes :id, :description
  
end
