class ServiceSerializer < ActiveModel::Serializer
  # has_one :user
  attributes :id, :description, :subcategory_id, :price, :is_fixed_price

end
