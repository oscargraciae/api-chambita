class AddColumnVisitsToUser < ActiveRecord::Migration
  def change
    add_column :services, :visits, :integer, default: 0
  end
end
