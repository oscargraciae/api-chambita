class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.datetime :birthdate
      t.string :cellphone
      t.text :description
      t.text :avatar
      t.text :token

      t.timestamps null: false
    end
  end
end
