class UserSerializer < ActiveModel::Serializer
  # embed :ids, include: true
  attributes :id, :first_name, :last_name, :email, :description, :avatar
  # root 'data'
  has_many :services
end
