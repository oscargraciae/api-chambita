class PackageSerializer < ActiveModel::Serializer
  attributes :id, :description, :price, :unit_type_id, :unit_type, :unit_max, :is_principal

  has_one :unit_type
end
