class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :notified_by, index: true
      t.references :request_service, index: true
      t.integer :identifier
      t.string :type
      t.boolean :read

      t.timestamps null: false
    end

    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :notified_by_id
    add_foreign_key :notifications, :request_services
  end
end
