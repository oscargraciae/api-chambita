class AddLatLngToService < ActiveRecord::Migration
	def self.up
		add_column :services,:lat,:float
		add_column :services,:lng,:float
  	end
  	def self.down
    	remove_column :services,:lat
    	add_column :services,:lng
  	end
end
