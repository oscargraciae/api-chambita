class Package < ActiveRecord::Base

  belongs_to :unit_type
  belongs_to :service

  validate :unit_type_validation

  private
  def unit_type_validation
    self.unit_type_id = nil if self.unit_type_id == 0
  end
end
