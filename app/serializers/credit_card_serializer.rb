class CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :token, :last4, :brand, :active
  has_one :user
end
