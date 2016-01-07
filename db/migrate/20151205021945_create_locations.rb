class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location
      t.decimal :geo_lat, precision: 9, scale: 6
      t.decimal :geo_lng, precision: 9, scale: 6
      t.string :route
      t.string :locality
      t.string :administrative_area
      t.string :country

      t.timestamps null: false
    end
  end
end
