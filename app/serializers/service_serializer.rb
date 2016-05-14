class ServiceSerializer < ActiveModel::Serializer

  #has_one :user
  attributes :id, :name, :description, :price, :created_at, :updated_at, :published, :cover, :cover_thumb, :avg_rating, :total_jobs
  has_one :sub_category
  has_one :category, serializer: CategoryShortSerializer
  has_many :service_images
  has_one :user, serializer: UserShortSerializer

  def cover_thumb
  	object.cover.url(:thumb)
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
    
    total
  end

  def avg_rating_quality
    ratings = Rating.joins(:evaluation).where(evaluations: {service_id: object.id}, ratings: {rating_type_id: 2})

    if ratings.length > 0
      total = ratings.sum(:value).to_f / ratings.size
    else
      total = 0
    end
    
    total

  end

  def avg_rating_time
    ratings = Rating.joins(:evaluation).where(evaluations: {service_id: object.id}, ratings: {rating_type_id: 3})

    if ratings.length > 0
      total = ratings.sum(:value).to_f / ratings.size
    else
      total = 0
    end
    
    total
  end


  def avg_rating
    sum = avg_rating_time + avg_rating_price + avg_rating_quality

    total = sum / 3

    total.round(1)

  end

end