class RequestService < ActiveRecord::Base
  belongs_to :supplier, class_name: "User", inverse_of: :supplier

  belongs_to :service
  belongs_to :user
  belongs_to :request_status
  has_many :request_message
  
  def self.jobs(params)
	request= RequestService.joins(:service).where(services: { user_id: params[:user_id] })
	puts request.as_json

	request
  end
end
