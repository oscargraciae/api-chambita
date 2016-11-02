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

FactoryGirl.define do
  factory :credit_card do
    user nil
    token 'MyString'
    last4 'MyString'
    brand 'MyString'
    active false
  end
end
