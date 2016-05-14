class RequestServiceSerializer < ActiveModel::Serializer
  attributes :id, :message, :request_date, :request_time, :price, :fee, :created_at, :is_finish_supplier, :is_finish_customer, :is_evaluated
  has_one :service
  has_one :user
  has_one :request_status
  has_many :request_message
  has_one :supplier
  
  def request_message
    object.request_message.order(created_at: :desc)
  end  

end

#class ArrayRequestServiceSerializer < ActiveModel::ArraySerializer

#end
