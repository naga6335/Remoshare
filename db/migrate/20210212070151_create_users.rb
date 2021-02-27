class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest, null: false
      t.string :remember_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
