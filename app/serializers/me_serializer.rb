class MeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :description, :avatar, :avatar_thumb, :address
  # root 'data'
  
  def avatar_thumb
  	object.avatar.url(:thumb)
  end

  def address
  	[object.city, object.state, object.country].compact.join(', ')
  end
end
