class AddColumnSupplierToUser < ActiveRecord::Migration
  def change
  	add_column :request_services, :supplier_id, :integer
  end
end
