class ChangeReaditToInboxMessage < ActiveRecord::Migration
  def up
    change_column :inbox_messages, :readit, :boolean, default: false
  end

  def down
    change_column :inbox_messages, :readit, :boolean
  end
end
