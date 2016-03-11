class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :sub_categories
  belongs_to :service
end
