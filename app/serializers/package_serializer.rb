# == Schema Information
#
# Table name: packages
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  price        :decimal(, )
#  unit_type_id :integer
#  unit_max     :integer
#  service_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_principal :boolean          default(FALSE)
#  active       :boolean          default(TRUE)
#

class PackageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :unit_type_id, :unit_type, :unit_max, :is_principal

  has_one :unit_type

  # def price
  #   object.order(price: :desc)
  # end

end
