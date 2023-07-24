class AddOtherToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :status, :string
    add_column :viprs, :req_email, :string
    add_column :viprs, :subtotal, :decimal
    add_column :viprs, :vat, :decimal
    add_column :viprs, :total, :decimal
    add_column :viprs, :user_id, :integer
    add_column :viprs, :is_vat, :boolean
    
  end
end
