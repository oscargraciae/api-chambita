# == Schema Information
#
# Table name: request_services
#
#  id                 :integer          not null, primary key
#  message            :text
#  request_date       :date
#  request_time       :time
#  request_status_id  :integer          default(3)
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
#

class RequestServiceSerializer < ActiveModel::Serializer
  attributes :id, :message, :request_date, :request_time, :price, :fee, :created_at, :is_finish_supplier, :is_finish_customer, :is_evaluated
  
  has_one :request_status
  has_one :user, serializer: UserShortSerializer
  has_one :supplier, serializer: UserShortSerializer
	has_one :service, serializer: ServiceOnlySerializer
	
  def request_message
    object.request_message.order(created_at: :desc)
  end  

end