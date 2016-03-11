class ChangeCategoryToService < ActiveRecord::Migration
  def change
    rename_column :services, :subcategory_id, :category
    add_column :services, :service_type, :integer
  end
end
