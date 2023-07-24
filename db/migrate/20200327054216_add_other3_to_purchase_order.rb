class AddOther3ToPurchaseOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_orders, :disc, :decimal
    add_column :purchase_orders, :totbefdisc, :decimal
  end
end
