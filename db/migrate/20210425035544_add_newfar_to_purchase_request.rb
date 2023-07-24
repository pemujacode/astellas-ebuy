class AddNewfarToPurchaseRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_requests, :approval_group, :string
  end
end
