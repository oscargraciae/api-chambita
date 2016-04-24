class AddColumnPriceToRequestService < ActiveRecord::Migration
  def change
  	add_column :request_services, :price, :decimal
  	add_column :request_services, :fee, :decimal
  end
end
