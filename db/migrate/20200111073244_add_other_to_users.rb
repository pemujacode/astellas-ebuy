class AddOtherToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :integer
    add_column :users, :emp_id, :string
    add_column :users, :title, :string
    add_column :users, :grade, :string
    add_reference :users, :department, null: true, foreign_key: true
    add_column :users, :is_active, :boolean
  end
end
