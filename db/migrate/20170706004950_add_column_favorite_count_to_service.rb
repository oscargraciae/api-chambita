class AddColumnFavoriteCountToService < ActiveRecord::Migration
  def change
    add_column :services, :favorite_count, :integer, default: 0
  end
end
