class AddOther1ToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :po_no, :string
    add_column :viprs, :pic, :string
  end
end
