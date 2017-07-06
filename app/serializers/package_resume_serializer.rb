class PackageResumeSerializer < ActiveModel::Serializer
  attributes :id, :price, :unit_type

  has_one :unit_type

end
