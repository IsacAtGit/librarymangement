class AddColumnsToTheAuthorTable < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :first_name, :string
    add_column :authors, :last_name, :string
    add_column :authors, :date_of_birth, :date
  end
end
