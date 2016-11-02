class AddColumnIsEvaluatedToRequestService < ActiveRecord::Migration
  def change
    add_column :request_services, :is_evaluated, :boolean, default: false
  end
end
