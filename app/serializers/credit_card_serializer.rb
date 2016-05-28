# == Schema Information
#
# Table name: credit_cards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string
#  last4      :string
#  brand      :string
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :last4, :brand, :active
  #has_one :user

  def brand
    if object.brand == "MC"
      "MasterCard"      
    end  
  end

end
