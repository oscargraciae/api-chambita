# == Schema Information
#
# Table name: inboxes
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :inbox do
    sender_id 1
    recipient_id 1
  end
end
