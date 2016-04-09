class UserSerializer < ActiveModel::Serializer
  # embed :ids, include: true
  attributes :id, :first_name, :last_name, :email, :description, :avatar, :avatar_thumb, :address
  # root 'data'
  has_many :services

  def avatar_thumb
  	object.avatar.url(:thumb)
  end

  def address
  	[object.city, object.state, object.country].compact.join(', ')
  end


end
