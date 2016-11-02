# == Schema Information
#
# Table name: orders
#
#  id                 :integer          not null, primary key
#  request_service_id :integer
#  order_status_id    :integer
#  service_price      :decimal(, )
#  fee                :decimal(, )
#  total              :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :order do
    request_services nil
    order_status nil
    service_price '9.99'
    fee '9.99'
    total '9.99'
  end
end
