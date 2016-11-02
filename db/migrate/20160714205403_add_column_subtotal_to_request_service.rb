class AddColumnSubtotalToRequestService < ActiveRecord::Migration
  def change
    add_column :request_services, :subtotal, :decimal, precision: 8, scale: 2
    add_column :request_services, :quantity, :integer, default: 1
  end
end
