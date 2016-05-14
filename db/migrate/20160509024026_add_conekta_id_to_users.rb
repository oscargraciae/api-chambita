class AddConektaIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :conektaid, :string
  end
end
