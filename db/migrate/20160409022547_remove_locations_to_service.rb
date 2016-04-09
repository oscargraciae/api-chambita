class RemoveLocationsToService < ActiveRecord::Migration
  def change
    remove_column :services, :url
    remove_column :services, :part_number
    remove_column :services, :country
    remove_column :services, :state
    remove_column :services, :locality
    remove_column :services, :lat
    remove_column :services, :lng
  end
end
