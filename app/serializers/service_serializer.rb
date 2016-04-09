class ServiceSerializer < ActiveModel::Serializer
  #has_one :user
  attributes :id, :name, :description, :price, :created_at, :updated_at, :published, :cover, :cover_thumb, :cover_small, :user_name, :user_avatar, :user_id, :user_address
  has_one :sub_category
  has_one :category
  has_many :service_images
  # has_one :user

  def cover_thumb
  	object.cover.url(:thumb)
  end

  def cover_small
  	object.cover.url(:small)
  end

  def user_name
    object.user.first_name
  end

  def user_avatar
    object.user.avatar
  end

  def user_id
    object.user.id
  end

  def user_address
    [object.user.city, object.user.state, object.user.country].compact.join(', ')
  end

end