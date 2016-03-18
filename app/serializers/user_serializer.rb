class UserSerializer < ActiveModel::Serializer
  # embed :ids, include: true
  attributes :id, :first_name, :last_name, :email, :description, :avatar, :avatar_thumb
  # root 'data'
  has_many :services

  def avatar_thumb
  	object.avatar.url(:thumb)
  end
end
