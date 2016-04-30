class Order < ActiveRecord::Base
  belongs_to :request_services
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
