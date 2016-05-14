class ServiceDetailSerializer < ActiveModel::Serializer
  
  #has_one :user
  attributes :id, :name, :description, :price, :created_at, :updated_at, :published, :cover, :cover_thumb, :user_name, :user_avatar, :user_id, :user_address, :fee, :total_jobs, :avg_rating_price, :avg_rating_quality, :avg_rating_time, :avg_rating
  has_one :sub_category
  has_one :category, serializer: CategoryShortSerializer
  has_many :service_images
  has_one :user, serializer: UserShortSerializer

  def cover_thumb
  	object.cover.url(:thumb)
  end

  def user_name
    
    [object.user.first_name, object.user.last_name].compact.join(' ')
  end

  def user_avatar
    object.user.avatar
  end

  def user_id
    object.user.id
  end

  def user_address
    [object.user.city, object.user.state, object.user.country].compact.join(', ')
  end

  def price
  	object.price.round(2)
  end

  def fee
    object.price = object.price * 0.12
  end

  def total_jobs
    total = RequestService.where({service_id: object.id, request_status_id: 4}).size

    total
  end

  def avg_rating_price
    ratings = Rating.joins(:evaluation).where(evaluations: {service_id: object.id}, ratings: {rating_type_id: 1})
    
    if ratings.length > 0
      
      total = ratings.sum(:value).to_f / ratings.size
    else
      
      total = 0
    end
    
    total.round(1)
  end

  def avg_rating_quality
    ratings = Rating.joins(:evaluation).where(evaluations: {service_id: object.id}, ratings: {rating_type_id: 2})

    if ratings.length > 0
      total = ratings.sum(:value).to_f / ratings.size
    else
      total = 0
    end
    
    total.round(1)

  end

  def avg_rating_time
    ratings = Rating.joins(:evaluation).where(evaluations: {service_id: object.id}, ratings: {rating_type_id: 3})

    if ratings.length > 0
      total = ratings.sum(:value).to_f / ratings.size
    else
      total = 0
    end
    
    total.round(1)
  end

  def avg_rating
    sum = avg_rating_time + avg_rating_price + avg_rating_quality

    total = sum / 3

    total.round(1)

  end

end
