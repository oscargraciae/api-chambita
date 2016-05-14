class CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :last4, :brand, :active
  has_one :user
end
