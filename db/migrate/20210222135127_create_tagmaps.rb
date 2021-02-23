class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
