class RequestService < ActiveRecord::Base
  belongs_to :supplier, class_name: "User", inverse_of: :supplier

  belongs_to :service
  belongs_to :user
  belongs_to :request_status
  has_many :request_message
  has_many :notifications, dependent: :destroy  
  
  scope :me, -> (user_id) { where user_id: user_id }
  scope :status, -> (status_id) { where request_status_id: status_id }
  scope :recent, -> { order created_at: :desc }


  def self.jobs_pending(user_id)
  	request= RequestService.joins(:service).where(services: { user_id: user_id }).status([3]).recent()
  	puts request.as_json

  	request
  end

  def self.jobs_inprocess(user_id)
    request= RequestService.joins(:service).where(services: { user_id: user_id }).status([1]).recent()
    puts request.as_json

    request
  end

  def self.jobs_finished(user_id)
    request= RequestService.joins(:service).where(services: { user_id: user_id }).status([2,4]).recent()
    puts request.as_json

    request
  end


  def self.all_pending(user_id)
    requests = RequestService.me(user_id).status([3]).recent()

    requests
  end

  def self.all_finish(user_id)
    requests = RequestService.me(user_id).status([2,4]).recent()

    requests
  end

  def self.all_inprogress(user_id)
    requests = RequestService.me(user_id).status([1]).recent()

    requests
  end

end
