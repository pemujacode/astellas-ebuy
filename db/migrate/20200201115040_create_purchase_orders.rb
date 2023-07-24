class CreatePurchaseOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders do |t|
      t.string :no
      t.date :po_date
      t.date :delivery_date
      t.string :buyer
      t.string :terms_payment
      t.string :status
      t.string :prepared_by
      t.string :reviewed_by
      t.string :approved_by
      t.string :currency
      t.numeric :total
      t.numeric :vat
      t.numeric :grand_total

      t.timestamps
    end
  end
end
