class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :tag_name, null: false

      t.timestamps
    end
    add_index :tags, :tag_name, unique: true
  end
end
