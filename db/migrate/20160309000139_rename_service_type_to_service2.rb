class RenameServiceTypeToService2 < ActiveRecord::Migration
  def change
    rename_column :services, :subcategory_id, :sub_category_id
  end
end
