class ServiceDetailSerializer < ActiveModel::Serializer
  # INFORMACION PUBLICA DE SERVICIO
  # ES UTILIZADA PARA MOSTRAR EL DETALLE DEL SERVICIO
  attributes :id, :name, :description, :price, :cover, :rating_general, :service_ratings, :unit_max, :favorite_count

  has_one :sub_category
  has_one :category
  has_one :user, serializer: UserShortSerializer

  has_many :packages

  def price
    object.price
  end

  def packages
    object.packages.order(price: :asc)
  end

end
