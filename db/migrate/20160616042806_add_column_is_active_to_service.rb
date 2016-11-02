class AddColumnIsActiveToService < ActiveRecord::Migration
  def change
    add_column :services, :isActive, :boolean, default: true
  end
end
