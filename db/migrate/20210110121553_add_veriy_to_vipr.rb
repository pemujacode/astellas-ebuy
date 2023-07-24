class AddVeriyToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :verify1, :string
    add_column :viprs, :verifyemail1, :string
    add_column :viprs, :verifyemail2, :string
    add_column :viprs, :verifyemail3, :string
    add_column :viprs, :verify2, :string
    add_column :viprs, :verify3, :string
  end
end
