class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.integer :subcategory_id
      t.decimal :price
      t.boolean :is_fixed_price

      t.timestamps null: false
    end
  end
end
