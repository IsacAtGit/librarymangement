class AddColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :mobilenumber, :string
    add_column :users, :password, :string
  
    add_index :users, :mobilenumber, unique: true
  end
end
