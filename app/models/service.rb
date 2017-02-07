# == Schema Information
#
# Table name: services
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  category_id        :integer
#  price              :decimal(8, 2)
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
#  rating_general     :decimal(8, 1)    default(0.0)
#  total_jobs         :integer          default(0)
#  isActive           :boolean          default(TRUE)
#  unit_type_id       :integer
#  unit_max           :integer
#  visits             :integer          default(0)
#

class Service < ActiveRecord::Base
  validates :name, length: { maximum: 60 }
  validates :description, length: { maximum: 1000 }
  # validates :price, length: { maximum: 25 }
  # validate  :unit_type_validation

  reverse_geocoded_by 'users.lat', 'users.lng'

  belongs_to :user
  belongs_to :sub_category
  belongs_to :unit_type
  belongs_to :category
  has_many :service_images
  has_many :packages

  # before_create :total_service_for_user
  # before_create :default_values

  do_not_validate_attachment_file_type :cover
  has_attached_file   :cover,
                      #:styles => { :small => ["128x128!",:jpg], :meddium => ["230x230!",:jpg], :thumb => ["90x90#", :jpg]},
                      styles: { small: ['128x128!', :jpg], meddium: ['300x300!', :jpg], thumb: ['268x134#', :jpg] },
                      #:styles => { :small => ["128x128!",:jpg], :meddium => ["460x230!",:jpg] },
                      default_style: :meddium,
                      storage: :s3,
                      url: ':s3_domain_url',
                      #:default_url => 'https://chambita_production.s3.amazonaws.com/uploads/users/user_default.png',
                      default_url: 'https://s3.amazonaws.com/chambita_production/uploads/users/user_default.png',

                      path: 'uploads/services/cover/:file_id/:style/:filename'

  # default_scope { includes(:service_images) }
  scope :active, -> { where(isActive: true) }
  scope :user, -> (user_id) { where user_id: user_id }
  scope :top, -> { limit(2) }
  scope :recent, -> { order(updated_at: :desc) }
  scope :add_include, -> { includes(:category, :user, :sub_category, :service_images) }
  # scope :location, -> (km, lat, lng) { joins(:user).near([lat, lng], km, :order => false).where(published: true).order rating_general: :desc }
  scope :location, -> (km, lat, lng) { joins(:user).near([lat, lng], km, order: :distance).where(published: true).order rating_general: :desc }

  def self.all_services(lat, lng)
    Service.joins(:user).location(SEARCH_DEFAULT_KM, lat, lng).add_include.active
  end

  def self.service_by_user_id(user_id)
    Service.where(user_id: user_id).recent.includes(:sub_category).active
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
      location = Geocoder.search('Monterrey, Nuevo Leon, Mexico')[0]
      lat = location.coordinates[0]
      lng = location.coordinates[1]
    end

    services = Service.all
    services = services.where(['lower(no_accent(services.name)) LIKE ? OR lower(no_accent(services.description)) LIKE ?', "%#{query.downcase.removeaccents}%", "%#{query.downcase.removeaccents}%"]) if query.present?
    # services = services.where(name: params[:category]) if params[:category].present?
    if params[:category].present?
      category = params[:category].gsub('-',' ')
      services = services.joins(:category).where('lower(categories.name) = ?', "#{category.downcase}")
    end

    if params[:sub_category].present?
      sub_category = params[:sub_category].gsub('-',' ')
      services = services.joins(:sub_category).where('lower(sub_categories.name) = ?', "#{sub_category.downcase}")
    end



    services = services.joins(:user).near([lat, lng], 40, order: false).where(isActive: true, published: true).order(rating_general: :desc, created_at: :desc).order("packages.price").includes(:sub_category, :user, :packages, :unit_type)
    # services.joins(:user).location(SEARCH_DEFAULT_KM, lat, lng).add_include().active()
    services
  end

  def self.all_cached
    Rails.cache.fetch('Service.all') { all }
  end

  # Aqui validamos el limite de servicios permitidos por usuario, el maximo son 15
  def total_service_for_user
    total = 0
    total = Service.where(user_id: user_id).count
    if total >= 15
      errors.add('general', 'Ha superado el limite de servicios permitidos')
      return false
    end
  end

  def service_ratings
    # service = Service.find(id)
    Rating.get_ratings_by_service_id(id)
  end

  #def default_values
  #  self.published = false
  #end

  private
  def unit_type_validation
    self.unit_type_id = nil if self.unit_type_id == 0
  end

  def self.get_location(params)
    if params[:lat] && params[:lng]
      lat = params[:lat]
      lng = params[:lng]
    elsif params[:location]
      location = Geocoder.search(params[:location])[0]
      lat = location.coordinates[0]
      lng = location.coordinates[1]
    else
      location = Geocoder.search(DEFAULT_LOCATION)[0]
      lat = location.coordinates[0]
      lng = location.coordinates[1]
    end

    return lat, lng
  end


  # private
  # def validate_company_id
  #   self.unit

  #   cp = Company.find_by_company_id(self.company)
  #   if cp.nil?
  #     errors.add(:company, 'Invalid Company ID')
  #   end
  # end

end
