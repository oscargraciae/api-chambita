class AddColumnIsActiveEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :IsActiveEmail, :boolean, default: false
  end
end
