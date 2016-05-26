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

class ServiceSerializer < ActiveModel::Serializer

  #has_one :user
  attributes :id, :name, :description, :price, :created_at, :updated_at, :published, :cover, :cover_thumb, :rating_general
  #, :total_jobs
  #, :service_ratings
  has_one :sub_category
  # has_one :category, serializer: CategoryShortSerializer
  has_many :service_images
  has_one :user, serializer: UserShortSerializer

  def cover_thumb
  	object.cover.url(:thumb)
  end

end
