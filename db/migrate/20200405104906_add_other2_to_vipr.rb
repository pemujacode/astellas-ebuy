class AddOther2ToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :doctype, :string
  end
end
