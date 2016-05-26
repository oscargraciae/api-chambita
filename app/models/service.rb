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


  #default_scope -> { order(avg_rating: :desc) }
  
  scope :user, -> (user_id) { where user_id: user_id }
  scope :top, -> { limit(2) }
  scope :recent, -> { order(updated_at: :desc) }

  def self.all_services(lat, lng)
    services = Service.all
    services = services.joins(:user).near([lat, lng], 100*0.30, user:{:order => :distance}).includes(:category, :user, :sub_category, :service_images)
    services
  end

  def self.all_cached
    Rails.cache.fetch('Service.all') { all }
  end

  def self.search(params = {})
    services = params[:services_ids].present? ? Service.where(id: params[:services_ids]) : Service.all
    services = services.order(id: :desc)
    services = services.user(params[:user_id]) if params[:user_id].present?
    services = services.top() if params[:top].present?
    services = services.recent() if params[:recent].present?
    services = services.joins(:user).near([lat, lng], 100*0.25, user:{:order => :distance})
    services
  end

  def self.search_service(params)
    query = params[:q]

    # Consultamos la informacion de la ubicacion al API de Google maps 
    location = Geocoder.search(params[:location])[0]
    # obtenemos las cordenadas de la ubicacion
    lat = location.coordinates[0]
    lng = location.coordinates[1]

    services = Service.where(["lower(name) LIKE ? ", "%#{query.downcase}%"])
    services = services.where(category_id: params[:category]) if params[:category].present?
    services = services.where(sub_category_id: params[:sub_category]) if params[:sub_category].present?
    # obtenemos los servicios que esten a 60 kilometros a la redonda de las cordeandas
    services = services.joins(:user).near([lat, lng], 100*0.25, user:{:order => :distance})
    puts services.as_json
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

  def service_ratings
    Rating.get_ratings_by_service_id(self.id)
  end

  def total_jobs
    total = RequestService.where({service_id: self.id, request_status_id: 4}).size

    total
  end

  # def avg_rating_price
  #   ratings = Rating.joins(:evaluation).where(evaluations: {service_id: self.id}, ratings: {rating_type_id: 1})
    
  #   if ratings.length > 0

  #     total = ratings.sum(:value).to_f / ratings.size
  #   else

  #     total = 0
  #   end
    
  #   total
  # end

  # def avg_rating_quality
  #   ratings = Rating.joins(:evaluation).where(evaluations: {service_id: self.id}, ratings: {rating_type_id: 2})

  #   if ratings.length > 0
  #     total = ratings.sum(:value).to_f / ratings.size
  #   else
  #     total = 0
  #   end
    
  #   total

  # end

  # def avg_rating_time
  #   ratings = Rating.joins(:evaluation).where(evaluations: {service_id: self.id}, ratings: {rating_type_id: 3})

  #   if ratings.length > 0
  #     total = ratings.sum(:value).to_f / ratings.size
  #   else
  #     total = 0
  #   end
    
  #   total
  # end


  def avg_rating
    #sum = avg_rating_time + avg_rating_price + avg_rating_quality

    #total = sum / 3

    #total.round(1)

    0

  end


  def default_values
    self.published = true
  end

end
