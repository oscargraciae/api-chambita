class MeDetailSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :avatar, :lat, :lng, :username, :is_supplier
end
