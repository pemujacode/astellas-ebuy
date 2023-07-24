class AddOther2ToViprItem < ActiveRecord::Migration[6.0]
  def change
    add_column :vipr_items, :item, :string
    add_column :vipr_items, :status, :string
  end
end
