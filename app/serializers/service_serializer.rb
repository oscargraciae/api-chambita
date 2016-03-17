class ServiceSerializer < ActiveModel::Serializer
  #has_one :user
  attributes :name, :description, :country, :state, :locality, :created_at, :updated_at, :published
  has_one :sub_category
  has_one :category
  # has_one :user
end