class AddServiceRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :service, index: true, foreign_key: true
  end
end
