class AddTotalToRequestService < ActiveRecord::Migration
  def change
    add_column :request_services, :total, :decimal
  end
end
