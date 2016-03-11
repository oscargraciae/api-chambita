class AddPartNumberToService < ActiveRecord::Migration
  def change
    add_column :services, :part_number, :string
  end
end
