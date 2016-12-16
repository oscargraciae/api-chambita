class AdminUsersSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :full_name, :description, :avatar, :avatar_thumb, :address, :address_street, :address_area, :address_zipcode, :cellphone, :created_at

  def avatar_thumb
    object.avatar.url(:thumb)
  end

  def address
    [object.city, object.state, object.country].compact.join(', ')
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

end
