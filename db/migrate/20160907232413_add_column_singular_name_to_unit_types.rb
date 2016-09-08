class AddColumnSingularNameToUnitTypes < ActiveRecord::Migration
  def change
    add_column :unit_types, :singular_name, :string
  end
end
