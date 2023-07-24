class AddOther3ToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :disc, :decimal
    add_column :viprs, :totbefdisc, :decimal
    add_column :viprs, :grand_total, :decimal
  end
end
