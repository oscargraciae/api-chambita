class ServiceOnlySerializer < ActiveModel::Serializer
  #INORMACION DE SERVICIO PUBLICA EN RESUMEN
  attributes :id, :name, :description, :cover, :price, :rating_general, :subcategory

  def subcategory
    object.sub_category
  end

end
