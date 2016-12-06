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

end
