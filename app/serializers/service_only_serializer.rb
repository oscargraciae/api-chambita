class ServiceOnlySerializer < ActiveModel::Serializer
  #INORMACION DE SERVICIO PUBLICA EN RESUMEN
  
  attributes :id, :name, :description, :cover, :price, :rating_general
end
