class ServiceByUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :cover, :rating_general, :total_jobs

  has_one :unit_type
  has_one :sub_category

  has_many :packages, serializer: PackageResumeSerializer
end
