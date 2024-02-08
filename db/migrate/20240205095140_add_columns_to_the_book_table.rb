class AddColumnsToTheBookTable < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :title, :string
    add_column :books, :stock, :integer
    add_column :books, :price, :integer
    add_column :books, :genre, :string
    add_column :books, :description, :text
    add_reference :books, :author, foreign_key: true, null: false
  end
end
