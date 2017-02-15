class AddColumnIsSupplierToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_supplier, :boolean, default: false
  end
end
