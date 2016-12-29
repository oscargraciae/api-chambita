class AdminOrdersSerializer < ActiveModel::Serializer
  attributes :id, :request_service_id, :service_price, :total, :fee, :created_at

  #has_one :request_service, serializer: RequestServiceSerializer
  
end
