class AddOtherToPurchaseRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_requests, :status, :string
    add_column :purchase_requests, :req_email, :string
    add_column :purchase_requests, :approval1, :string
    add_column :purchase_requests, :approval2, :string
    add_column :purchase_requests, :approval3, :string
    add_column :purchase_requests, :approval4, :string
    add_column :purchase_requests, :apv_date1, :datetime
    add_column :purchase_requests, :apv_date2, :datetime
    add_column :purchase_requests, :apv_date3, :datetime
    add_column :purchase_requests, :apv_date4, :datetime
    add_column :purchase_requests, :allocation, :string
    add_column :purchase_requests, :supplier, :string
    add_column :purchase_requests, :costcenter, :string
    add_column :purchase_requests, :item, :string
    add_column :purchase_requests, :quantity, :decimal
    add_column :purchase_requests, :price, :decimal
    add_column :purchase_requests, :supplier_reason, :string
    add_column :purchase_requests, :purpose, :string
    add_column :purchase_requests, :detail, :string
    add_column :purchase_requests, :no_approval, :integer
    add_column :purchase_requests, :apv_remarks, :string
    add_column :purchase_requests, :pic, :string


  end
end
