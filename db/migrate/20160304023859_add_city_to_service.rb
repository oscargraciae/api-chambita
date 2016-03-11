class AddCityToService < ActiveRecord::Migration
  def change
    add_column :services, :city, :string
  end
end
