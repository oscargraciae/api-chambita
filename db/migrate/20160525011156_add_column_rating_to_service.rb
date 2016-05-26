class AddColumnRatingToService < ActiveRecord::Migration
  def change
  	add_column :services, :rating_general, :decimal, :precision => 8, :scale => 1
  	add_column :services, :total_jobs, :integer
  end
end
