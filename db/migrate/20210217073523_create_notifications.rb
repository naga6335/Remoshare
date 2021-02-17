class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor_id, null: false, foreign_key: { to_table: users }
      t.references :visitor_id, null: false, foreign_key: { to_table: users }
      t.references :visited_id, null: false, foreign_key:
      t.references :post, null: true, foreign_key: true
      t.references :comment, null: true, foreign_key: true
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
