class CreatePurchaseOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_order_items do |t|
      t.references :purchase_order, null: false, foreign_key: true
      t.string :no
      t.string :product
      t.string :spesification
      t.string :costcenter
      t.numeric :price
      t.numeric :quantity
      t.numeric :amount

      t.timestamps
    end
  end
end  




