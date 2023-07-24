class AddOther4ToPurchaseOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_orders, :doctype, :string
  end
end
