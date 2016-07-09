class AddColumnsToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :supplier_id, :integer
    add_column :evaluations, :subcategory_id, :integer
  end
end
