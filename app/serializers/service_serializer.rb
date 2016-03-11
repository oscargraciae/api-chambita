class ServiceSerializer < ActiveModel::Serializer
  # has_one :user
  attributes :id, :name, :description, :price, :is_fixed_price, :country, :state, :locality, :created_at, :updated_at, :published 
  belongs_to :sub_category
end
