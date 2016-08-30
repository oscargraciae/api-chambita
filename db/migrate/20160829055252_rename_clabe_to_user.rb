class RenameClabeToUser < ActiveRecord::Migration
  def change
    rename_column :users, :CLABE, :clabe
  end
end
