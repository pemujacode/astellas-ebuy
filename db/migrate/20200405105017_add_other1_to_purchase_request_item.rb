class AddOther1ToPurchaseRequestItem < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_request_items, :dept, :string
    add_column :purchase_request_items, :spesification, :string
  end
end
