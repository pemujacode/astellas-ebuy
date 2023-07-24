class AddDpToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :dp, :numeric
    add_column :viprs, :net_payment, :numeric
  end
end
