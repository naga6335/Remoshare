class AddFormToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :title, :string, null: false
    add_column :posts, :review, :integer, null: false
  end
end
