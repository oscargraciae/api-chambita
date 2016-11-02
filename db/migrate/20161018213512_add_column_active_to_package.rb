class AddColumnActiveToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :active, :boolean, default: true
  end
end
