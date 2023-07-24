class AddOther2ToPurchaseOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_order_items, :item, :string
    add_column :purchase_order_items, :status, :string
  end
end
