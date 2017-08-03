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

class ServiceSerializer < ActiveModel::Serializer
  # ESTE SERIALIZER ES UTILIZADO PARA ENVIAR EL RESUMEN DE LA INFORMACION DEL SERVICIO
  # UNICAMENTE LLENAMOS LOS service-card.html

  attributes :id, :name, :description, :price, :cover, :rating_general, :total_jobs, :favorite_count

  has_one :unit_type
  has_one :sub_category
  has_one :user, serializer: UserShortSerializer

  has_many :packages, serializer: PackageResumeSerializer
  has_many :favorites

  def packages
    object.packages.order(price: :asc)
  end
  
  # def packages
  #   object.packages.order(price: :asc)
  # end
end
