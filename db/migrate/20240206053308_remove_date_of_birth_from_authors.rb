class RemoveDateOfBirthFromAuthors < ActiveRecord::Migration[7.1]
  def change
    remove_column :authors, :date_of_birth, :date
  end
end
