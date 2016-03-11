class SubCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :category
  belongs_to :service
end
