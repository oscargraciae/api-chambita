class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email
  has_many :services

  def cache_key
    [object, scope]
  end
end
