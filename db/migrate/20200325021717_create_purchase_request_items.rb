class CreatePurchaseRequestItems < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_request_items do |t|
      t.references :purchase_request, null: false, foreign_key: true
      t.string :no
      t.string :product
      t.decimal :quantity

      t.timestamps
    end
  end
end
