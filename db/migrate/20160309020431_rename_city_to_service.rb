class RenameCityToService < ActiveRecord::Migration
  def change
    rename_column :services, :city, :locality
  end
end
