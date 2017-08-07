class ChangeReadToInboxMessage < ActiveRecord::Migration
  def change
    rename_column :inbox_messages, :readit, :read
  end
end
