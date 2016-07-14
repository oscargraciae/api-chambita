class ServiceOnlySerializer < ActiveModel::Serializer
  #INORMACION DE SERVICIO PUBLICA EN RESUMEN
  attributes :id, :name, :description, :cover, :price, :rating_general, :subcategory
  has_one :unit_type
  
  def subcategory
    object.sub_category
  end

end
