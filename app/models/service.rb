# == Schema Information
#
# Table name: services
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  category_id        :integer
#  price              :decimal(, )
#  is_fixed_price     :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  sub_category_id    :integer
#  published          :boolean
#  cover_file_name    :string
#  cover_content_type :string
#  cover_file_size    :integer
#  cover_updated_at   :datetime
#

class Service < ActiveRecord::Base
  
  validates :name, length: { maximum: 60 }
  validates :description, length: { maximum: 400 }
  validates :price, length: { maximum: 25 }
  
  reverse_geocoded_by "users.lat", "users.lng"

  belongs_to :user
  belongs_to :sub_category
  belongs_to :unit_type
  belongs_to :category
  has_many :service_images

  before_create :total_service_for_user
  before_create :default_values

  do_not_validate_attachment_file_type :cover
  has_attached_file   :cover,
                        #:styles => { :small => ["128x128!",:jpg], :meddium => ["230x230!",:jpg], :thumb => ["90x90#", :jpg]},
                        :styles => { :small => ["128x128!",:jpg], :meddium => ["230x230!",:jpg] },
                        :default_style => :meddium,
                        :storage => :s3,
                        :url  => ':s3_domain_url',
                        :default_url => 'http://chambita1236.s3.amazonaws.com/uploads/users/user_default.png',
                        :path => "uploads/services/cover/:file_id/:style/:filename"

  #default_scope { includes(:service_images) }
  scope :active, -> { where(isActive: true) }
  scope :user, -> (user_id) { where user_id: user_id }
  scope :top, -> { limit(2) }
  scope :recent, -> { order(updated_at: :desc) }
  scope :add_include, -> { includes(:category, :user, :sub_category, :service_images) }
  scope :location, -> (km, lat, lng) { joins(:user).near([lat, lng], km, :order => false).where(published: true).order rating_general: :desc }

  def self.all_services(lat, lng)
    Service.joins(:user).location(SEARCH_DEFAULT_KM, lat, lng).add_include().active()
  end

  def self.service_by_user_id(user_id)
    Service.where(user_id: user_id).recent().add_include.active()
  end

  def self.search_service(params)

    query = params[:q]
    if params[:lat] && params[:lng]
      lat = params[:lat]
      lng = params[:lng]
    elsif params[:location]
      location = Geocoder.search(params[:location])[0]
      lat = location.coordinates[0]
      lng = location.coordinates[1]
    else
      location = Geocoder.search("Monterrey, Nuevo Leon, Mexico")[0]
      lat = location.coordinates[0]
      lng = location.coordinates[1]
    end

    services = Service.all
    services = services.where(["lower(services.name) LIKE ? ", "%#{query.downcase}%"]) if query.present?
    services = services.where(category_id: params[:category]) if params[:category].present?
    services = services.joins(:sub_category).where(sub_categories: {name: params[:sub_category]}) if params[:sub_category].present?

    services.joins(:user).location(SEARCH_DEFAULT_KM, lat, lng).add_include().active()

  end

  def self.all_cached
    Rails.cache.fetch('Service.all') { all }
  end

  # Aqui validamos el limite de servicios permitidos por usuario, el maximo son 15
  def total_service_for_user
    total = 0
    total = Service.where(user_id: user_id).count
    if total >= 15
      errors.add("general" , "Ha superado el limite de servicios permitidos")
      return false
    end
  end

  def service_ratings
    service = Service.find(self.id)
    Rating.get_ratings_by_subcategory(service.sub_category_id, service.user_id)
  end

  def default_values
    self.published = true
  end

end
