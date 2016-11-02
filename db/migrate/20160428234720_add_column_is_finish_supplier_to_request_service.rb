class AddColumnIsFinishSupplierToRequestService < ActiveRecord::Migration
  def change
    add_column :request_services, :is_finish_supplier, :boolean, default: false
    add_column :request_services, :is_finish_customer, :boolean, default: false
  end
end
