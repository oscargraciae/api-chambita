# == Schema Information
#
# Table name: request_services
#
#  id                 :integer          not null, primary key
#  message            :text
#  request_date       :date
#  request_time       :time
#  request_status_id  :integer          default(1)
#  service_id         :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  price              :decimal(, )
#  fee                :decimal(, )
#  supplier_id        :integer
#  is_finish_supplier :boolean          default(FALSE)
#  is_finish_customer :boolean          default(FALSE)
#  is_evaluated       :boolean          default(FALSE)
#  total              :decimal(, )
#  token_card         :string
#  subtotal           :decimal(8, 2)
#  quantity           :integer          default(1)
#  package_id         :integer
#

FactoryGirl.define do
  factory :request_service do
    message 'MyText'
    request_date '2016-04-19'
    request_time '2016-04-19 14:43:22'
    references ''
    service nil
    user nil
  end
end
