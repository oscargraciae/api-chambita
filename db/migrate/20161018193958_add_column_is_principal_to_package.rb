class AddColumnIsPrincipalToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :is_principal, :boolean, default: false
  end
end
