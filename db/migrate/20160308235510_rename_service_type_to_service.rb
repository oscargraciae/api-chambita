class RenameServiceTypeToService < ActiveRecord::Migration
  def change
    rename_column :services, :service_type, :subcategory_id
  end
end
