class AddOtherToPurchaseOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_orders, :remarks, :string
    add_column :purchase_orders, :rls_date, :datetime
    add_column :purchase_orders, :apv_date, :datetime
    add_column :purchase_orders, :review_date, :datetime
    add_column :purchase_orders, :supplier, :string
    add_column :purchase_orders, :attn, :string
    add_column :purchase_orders, :user_id, :integer
    add_column :purchase_orders, :account, :string
    add_column :purchase_orders, :req_email, :string
    add_column :purchase_orders, :department, :string
    add_column :purchase_orders, :is_vat, :boolean
  
    
  end
end
