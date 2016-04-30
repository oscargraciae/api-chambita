class AddColumnsAddressToUser < ActiveRecord::Migration
  def change
  	add_column :users, :address_street, :string
  	add_column :users, :address_area, :string
  	add_column :users, :address_zipcode, :string
  end
end
