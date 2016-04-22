class RequestServiceSerializer < ActiveModel::Serializer
  attributes :id, :message, :request_date, :request_time
  has_one :service
  has_one :user
  has_one :request_status
  has_many :request_message

  def request_message
    object.request_message.order(created_at: :desc)
  end

end
