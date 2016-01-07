class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
  has_many :services

  def cache_key
    [object, scope]
  end
end
