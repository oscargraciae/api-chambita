class ChangeColumnTotaljobsToService < ActiveRecord::Migration
   def up
    change_column :services, :total_jobs, :integer, :default => 0
  end

  def down
    change_column :services, :total_jobs, :integer
  end
end
