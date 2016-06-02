class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :full_name, :avatar, :address, :address_street, :address_area, :address_zipcode, :cellphone

  def full_name
	"#{object.first_name} #{object.last_name}"
  end

  def address
    [object.city, object.state, object.country].compact.join(', ')
  end

end
