class ChangeColumnReadToInboxMessage < ActiveRecord::Migration
  def change
    change_column :inbox_messages, :readit, :boolean, :default => false
  end
end
