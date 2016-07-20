class ServiceDetailSerializer < ActiveModel::Serializer

  #INFORMACION PUBLICA DE SERVICIO
  # ES UTILIZADA PARA MOSTRAR EL DETALLE DEL SERVICIO
  attributes :id, :name, :description, :price, :cover, :rating_general, :service_ratings, :unit_max

  has_one :sub_category
  has_one :unit_type
  has_one :user, serializer: UserShortSerializer

  def price
  	object.price
  end

  # def fee
  #   object.price = object.price * 0.12
  # end

end
