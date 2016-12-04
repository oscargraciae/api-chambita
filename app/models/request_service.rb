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

class RequestService < ActiveRecord::Base
  validates :message, length: { maximum: 400 }

  belongs_to :supplier, class_name: 'User', inverse_of: :supplier
  belongs_to :service
  belongs_to :user
  belongs_to :request_status
  belongs_to :package
  # has_many :request_message
  # has_many :notifications, dependent: :destroy
  scope :me, -> (user_id) { where user_id: user_id }
  scope :status, -> (status_id = nil) { where request_status_id: status_id }
  scope :recent, -> { includes(:request_status, :user, :supplier, :service).order created_at: :desc }
  # includes(:request_status, :supplier, :user)

  def self.jobs_by_status(user_id, status_id)
    RequestService.where(services: { user_id: user_id }).status(status_id).recent
  end

  def self.pending_jobs(user_id, _status_id)
    RequestService.where(services: { user_id: user_id }).where(request_status_id: [2, 5]).recent
  end

  def self.jobs_history(user_id, _status_id)
    RequestService.where(services: { user_id: user_id }).where(request_status_id: [3, 4, 6]).recent
  end

  def self.requests_by_status(user_id, status_id)
    RequestService.me(user_id).status(status_id).recent
  end

  def self.pending_request(user_id)
    RequestService.me(user_id).where(request_status_id: [2, 5]).recent
  end

  def self.request_history(user_id)
    RequestService.me(user_id).where(request_status_id: [3, 4, 6]).recent
  end
end
