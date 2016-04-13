class Service < ActiveRecord::Base
  
  # after_validation :geocode
  
  #geocoded_by :address, :latitude  => :lat, :longitude => :lng # ActiveRecord

  reverse_geocoded_by "users.lat", "users.lng"

  belongs_to :user
  belongs_to :sub_category
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

  def self.all_cached
    Rails.cache.fetch('Service.all') { all }
  end

  def self.search(params = {})
    services = params[:services_ids].present? ? Service.where(id: params[:services_ids]) : Service.all

    services = services.order(id: :desc)

    services = services.user(params[:user_id]) if params[:user_id].present?
    services = services.top() if params[:top].present?
    services = services.recent() if params[:recent].present?

    services
  end

  def self.search_service(params)
    query = params[:q]

    # services = Service.all

    # Consultamos la informacion de la ubicacion al API de Google maps 
    location = Geocoder.search(params[:location])[0]
    # obtenemos las cordenadas de la ubicacion
    lat = location.coordinates[0]
    lng = location.coordinates[1]

    services = Service.where(["lower(name) LIKE ? ", "%#{query.downcase}%"])

    services = services.where(category_id: params[:category]) if params[:category].present?
    services = services.where(sub_category_id: params[:sub_category]) if params[:sub_category].present?
    
    # obtenemos los servicios que esten a 60 kilometros a la redonda de las cordeandas
    services = services.joins(:user).near([lat, lng], 100*0.62)

    services
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


  def default_values
    self.published = true
  end

end
