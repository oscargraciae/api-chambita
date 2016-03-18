class ServiceSerializer < ActiveModel::Serializer
  #has_one :user
  attributes :id, :name, :description, :country, :state, :locality, :price, :created_at, :updated_at, :published
  has_one :sub_category
  has_one :category
  has_many :service_images
  # has_one :user
end