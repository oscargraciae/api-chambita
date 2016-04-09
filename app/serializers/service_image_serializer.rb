class ServiceImageSerializer < ActiveModel::Serializer
  attributes :id, :img, :thumb

  def img
  	object.photo.url(:original)
  end

  def thumb
  	object.photo.url(:thumb)
  end
end
