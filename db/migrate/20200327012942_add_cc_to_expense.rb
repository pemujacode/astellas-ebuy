class AddCcToExpense < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :costcenter, :string
  end
end
