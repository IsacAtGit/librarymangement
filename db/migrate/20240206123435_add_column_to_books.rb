class AddColumnToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :isbn, :string

    add_index :books, :isbn, unique: true
  end
end
