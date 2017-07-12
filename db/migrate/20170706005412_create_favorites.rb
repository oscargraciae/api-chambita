class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :service, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
