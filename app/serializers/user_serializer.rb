class UserSerializer < ActiveModel::Serializer
  # embed :ids, include: true
  attributes :id, :first_name, :last_name, :email, :token
  # root 'data'
  # has_many :services

  def cache_key
    [object, scope]
  end
end
