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

class ServiceImage < ActiveRecord::Base
  belongs_to :service

  do_not_validate_attachment_file_type :photo
  has_attached_file :photo,
                    styles: { meddium: ['230x230!', :jpg], thumb: ['230x230#', :jpg] },
                    default_style: :meddium,
                    storage: :s3,
                    url: ':s3_domain_url',
                    default_url: 'http://chambita1236.s3.amazonaws.com/uploads/users/:style/user_default.png',
                    path: 'uploads/services/:file_id/:style/:filename'



  before_create :valid_total_images
   
  def self.delete_by_service_id(service_id)
    ServiceImage.where(service_id: service_id).destroy_all
  end

  def valid_total_images
    total = 0
    total = ServiceImage.where(service_id: service_id).count
    if total >= 6
      errors.add('general', 'Solo pude subir hasta 6 imágenes')
      return false
    end
  end

end
