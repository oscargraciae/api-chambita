class ServiceOnlySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :cover, :price, :rating_general
end
