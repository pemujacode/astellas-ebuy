class AddOtherToPurchaseRequestItem < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_request_items, :costcenter, :string
    add_column :purchase_request_items, :description, :string
    add_column :purchase_request_items, :remarks, :string
  end
end
