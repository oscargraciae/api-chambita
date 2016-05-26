class ChangeDefaultstatusToRequestService < ActiveRecord::Migration
  def up
    change_column :request_services, :request_status_id, :integer, :default => 1
  end

  def down
    change_column :request_services, :request_status_id, :integer, :default => 3
  end
end
