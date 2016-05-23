class CreateInboxMessages < ActiveRecord::Migration
  def change
    create_table :inbox_messages do |t|
      t.string :message
      t.integer :sender_user
      t.references :inbox, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
