class ServicePublicDetailSerializer < ActiveModel::Serializer

  #INFORMACION PUBLICA DE SERVICIO

  attributes :id, :name, :description, :price, :updated_at, :cover, :rating_general, :total_jobs

  has_one :sub_category
  has_one :category
  has_one :user, serializer: UserShortSerializer

  # def distance
  #   object.distance.round(2)
  # end
end
