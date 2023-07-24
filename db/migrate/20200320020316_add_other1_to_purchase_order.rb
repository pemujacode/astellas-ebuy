class AddOther1ToPurchaseOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_orders, :address, :string
    add_column :purchase_orders, :pic, :string
  end
end
