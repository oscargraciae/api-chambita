class ServicePublicDetailSerializer < ActiveModel::Serializer

  #INFORMACION PRIVADA DE SERVICIO
  # ES UTILIZADA PARA MOSTRAR EL RESUMEN DEL SERVICIO
  # EDITAR USUARIO
  attributes :id, :name, :description, :price, :cover

  has_one :sub_category
  has_many :service_images, includes: true

end
