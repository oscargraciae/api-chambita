class ChangeColumnStatusToRequest < ActiveRecord::Migration
  def change
    change_column :request_services, :request_status_id, :integer, default: 3
  end
end
