class AddOther1ToPurchaseOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_order_items, :dept, :string
    add_column :purchase_order_items, :description, :string
  end
end
