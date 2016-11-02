# == Schema Information
#
# Table name: notifications
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  notified_by_id     :integer
#  request_service_id :integer
#  identifier         :integer
#  type_notification  :string
#  read               :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :notification do
    user nil
    subscribed_user nil
    post nil
    identifier 1
    type ''
    read false
  end
end
