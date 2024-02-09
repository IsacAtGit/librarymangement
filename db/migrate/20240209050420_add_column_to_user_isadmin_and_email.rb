class AddColumnToUserIsadminAndEmail < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :email, :string

    User.update_all(is_admin: false)

    remove_column :users, :role
  end
end
