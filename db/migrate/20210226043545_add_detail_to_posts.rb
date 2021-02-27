class AddDetailToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :price, :integer
    add_column :posts, :issue, :string, null: false
  end
end
