class RenameCategoryToService < ActiveRecord::Migration
  def change
    rename_column :services, :category, :category_id
  end
end
