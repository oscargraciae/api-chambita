class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :title
      t.string :description
      t.decimal :price
      t.integer :unit_type_id
      t.integer :unit_max
      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
