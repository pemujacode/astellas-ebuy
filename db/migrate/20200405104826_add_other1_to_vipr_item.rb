class AddOther1ToViprItem < ActiveRecord::Migration[6.0]
  def change
    add_column :vipr_items, :dept, :string
    add_column :vipr_items, :description, :string
  end
end
