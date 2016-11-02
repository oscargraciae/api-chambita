class ChangeColumnRatingGeneralToService < ActiveRecord::Migration
  def up
    change_column :services, :rating_general, :decimal, precision: 8, scale: 1, default: 0
  end

  def down
    change_column :services, :rating_general, :decimal, precision: 8, scale: 1
  end
end
