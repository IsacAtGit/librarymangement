class RemoveIsbnToBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :isbn, :string
  end
end
