class CreateRequestServices < ActiveRecord::Migration
  def change
    create_table :request_services do |t|
      t.text :message
      t.date :request_date
      t.time :request_time
      t.references :request_status, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
