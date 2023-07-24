class AddSapnoToPurchaseOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_orders, :sapno, :string
  end
end
