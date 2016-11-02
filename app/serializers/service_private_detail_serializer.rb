class ServicePrivateDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :cover, :rating_general, :service_ratings, :unit_max, :published, :created_at, :updated_at, :visits, :total_jobs

  has_one :category
  has_one :sub_category
  has_one :unit_type

  def price
    object.price
  end
end
