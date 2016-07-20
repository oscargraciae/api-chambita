class ServiceOnlySerializer < ActiveModel::Serializer
  #INORMACION DE SERVICIO PUBLICA EN RESUMEN
  attributes :id, :name, :description, :cover, :price, :rating_general
  has_one :unit_type
  has_one :sub_category
  has_one :category

  def subcategory
    object.sub_category
  end
  
end
