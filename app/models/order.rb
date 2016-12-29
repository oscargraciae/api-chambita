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

class Order < ActiveRecord::Base
  belongs_to :request_service
  belongs_to :order_status

  def self.create(request_id, status_id, price, fee)
    order = Order.new
    order.request_service_id = request_id
    order.order_status_id = status_id
    order.service_price = price
    order.fee = fee
    order.total = price + fee
    order.save

    order
  end
end
