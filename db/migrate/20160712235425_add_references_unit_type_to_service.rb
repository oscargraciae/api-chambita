class AddReferencesUnitTypeToService < ActiveRecord::Migration
  def change
    add_reference :services, :unit_type, index: true, foreign_key: true
    add_column :services, :unit_max, :integer
  end
end
