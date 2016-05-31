class ServiceDetailSerializer < ActiveModel::Serializer
  
  # INFORMAION DE SERVICIO PUBLICA 

  #has_one :user
  attributes :id, :name, :description, :price, :created_at, :cover, :fee, :rating_general, :service_ratings
  has_one :sub_category
  #has_one :category, serializer: CategoryShortSerializer
  # has_many :service_images
  has_one :user, serializer: UserShortSerializer
  has_many :service_images, includes: true

  def price
  	object.price
  end

  def fee
    object.price = object.price * 0.12
  end

end
