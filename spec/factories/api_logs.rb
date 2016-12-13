# == Schema Information
#
# Table name: api_logs
#
#  id         :integer          not null, primary key
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  module     :string
#

FactoryGirl.define do
  factory :api_log do
    message 'MyString'
  end
end
