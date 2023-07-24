class AddNewfarToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :approval_group, :string
  end
end
