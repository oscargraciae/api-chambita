class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :request_service, index: true, foreign_key: true
      t.references :order_status, index: true, foreign_key: true
      t.decimal :service_price
      t.decimal :fee
      t.decimal :total

      t.timestamps null: false
    end
  end
end
