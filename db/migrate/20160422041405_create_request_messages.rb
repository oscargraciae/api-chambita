class CreateRequestMessages < ActiveRecord::Migration
  def change
    create_table :request_messages do |t|
      t.text :text
      t.integer :sender_id
      t.integer :recipient_id
      t.references :request_service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
