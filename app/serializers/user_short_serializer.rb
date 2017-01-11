class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :full_name, :avatar, :address, :description, :avatar_small, :username

  def avatar_small
    object.avatar.url(:small)
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def address
    [object.city, object.state, object.country].compact.join(', ')
  end
end
