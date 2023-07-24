class AddTambahan1ToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :vdate1, :date
    add_column :viprs, :vdate2, :date
    add_column :viprs, :vdate3, :date
  end
end
