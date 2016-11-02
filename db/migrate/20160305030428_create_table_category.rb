class CreateTableCategory < ActiveRecord::Migration
  def change
    create_table :table_categories do |t|
      t.string :name, null: false
    end
  end
end
