class Service < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :sub_category

  scope :user, -> (user_id) { where user_id: user_id }

  scope :top, -> {
    limit(2)
  }

  scope :recent, -> {
    order(updated_at: :desc)
  }
  # scope :top, -> (top) { limit user_id: user_id }

  # scope :status, -> (status) { where status: status }
  # scope :location, -> (location_id) { where location_id: location_id }
  # scope :starts_with, -> (name) { where("name like ?", "#{name}%")}

  def self.search(params = {})
    services = params[:services_ids].present? ? Service.where(id: params[:services_ids]) : Service.all

    services = services.user(params[:user_id]) if params[:user_id].present?
    services = services.top() if params[:top].present?
    services = services.recent() if params[:recent].present?

    services
  end

end
