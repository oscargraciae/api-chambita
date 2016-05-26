class ServiceDetailSerializer < ActiveModel::Serializer
  
  #has_one :user
  attributes :id, :name, :description, :price, :created_at, :updated_at, :published, :cover, :cover_thumb, :fee, :rating_general
  has_one :sub_category
  has_one :category, serializer: CategoryShortSerializer
  # has_many :service_images
  has_one :user, serializer: UserShortSerializer

  def cover_thumb
  	object.cover.url(:thumb)
  end

  def price
  	object.price.round(2)
  end

  def fee
    object.price = object.price * 0.12
  end

end
