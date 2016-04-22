class RequestService < ActiveRecord::Base
  belongs_to :service
  belongs_to :user
  belongs_to :request_status
  has_many :request_message
end
