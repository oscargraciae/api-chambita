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

class Package < ActiveRecord::Base

  belongs_to :unit_type
  belongs_to :service

  validate :unit_type_validation

  before_create :max_package

  default_scope { where(active: true) }

  private
  def unit_type_validation
    self.unit_type_id = nil if self.unit_type_id == 0
  end

  private
  def max_package
    total = 0
    total = Package.where(service_id: service_id).count
    if total >= 5
      errors.add('general', 'Solo puedes subir hasta 5 paquetes')
      return false
    end
  end

  # private
  # def default_title
  #   letter = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
  #   package_size = Package.where(service_id: self.service_id).size
  #   self.title = "Precio #{letter[package_size]}"
  # end

end
