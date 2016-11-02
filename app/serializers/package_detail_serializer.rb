class PackageDetailSerializer < ActiveModel::Serializer
  attributes :id, :description, :price, :unit_type_id, :unit_type, :unit_max

  has_one :unit_type
  has_one :service
end
