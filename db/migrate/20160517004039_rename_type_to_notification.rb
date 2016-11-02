class RenameTypeToNotification < ActiveRecord::Migration
  def change
    rename_column :notifications, :type, :type_notification
  end
end
