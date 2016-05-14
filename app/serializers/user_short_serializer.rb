class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :avatar

  def full_name
	"#{object.first_name} #{object.last_name}"
  end

end
