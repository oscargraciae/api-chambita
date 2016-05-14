class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :rating_type, index: true, foreign_key: true
      t.integer :value
      t.references :evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
