class AddDpAmountToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :dp_amount, :numeric
  end
end
