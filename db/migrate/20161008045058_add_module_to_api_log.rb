class AddModuleToApiLog < ActiveRecord::Migration
  def change
    add_column :api_logs, :module, :string
  end
end
