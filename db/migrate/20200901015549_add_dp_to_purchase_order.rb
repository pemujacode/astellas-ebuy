class AddDpToPurchaseOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_orders, :dp, :numeric
    add_column :purchase_orders, :net_payment, :numeric
  end
end
