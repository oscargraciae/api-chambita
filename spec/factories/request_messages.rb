# == Schema Information
#
# Table name: request_messages
#
#  id                 :integer          not null, primary key
#  text               :text
#  sender_id          :integer
#  recipient_id       :integer
#  request_service_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :request_message do
    text 'MyText'
    sender_id 1
    recipient_id 1
    RequestService nil
  end
end
