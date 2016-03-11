class AddStateToService < ActiveRecord::Migration
  def change
    add_column :services, :state, :string
  end
end
