class RemoveServiceIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :service_id, :integer
  end
end
