class AddClaebeToUser < ActiveRecord::Migration
  def change
    add_column :users, :CLABE, :string
    add_column :users, :bank, :string
  end
end
