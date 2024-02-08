class AddColumnToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :return_date, :date
    add_reference :orders, :user, foreign_key: true, null: false
    add_reference :orders, :book, foreign_key: true, null: false
  end
end
