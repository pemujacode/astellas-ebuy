class AddTambahanToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :tipe, :string
    add_column :viprs, :supplier_name, :string
  end
end
