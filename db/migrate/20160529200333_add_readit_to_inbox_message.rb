class AddReaditToInboxMessage < ActiveRecord::Migration
  def change
    add_column :inbox_messages, :readit, :boolean
  end
end
