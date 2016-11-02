# == Schema Information
#
# Table name: service_images
#
#  id                 :integer          not null, primary key
#  caption            :string
#  service_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  photo              :text
#

class ServiceImageSerializer < ActiveModel::Serializer
  attributes :id, :img, :thumb

  def img
    object.photo.url(:original)
  end

  def thumb
    object.photo.url(:thumb)
  end
end
