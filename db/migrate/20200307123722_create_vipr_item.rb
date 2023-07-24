class CreateViprItem < ActiveRecord::Migration[6.0]
  def change
    create_table :vipr_items do |t|
      t.references :vipr, null: false, foreign_key: true
      t.string :no
      t.string :product
      t.string :spesification
      t.string :costcenter
      t.decimal :price
      t.decimal :quantity
      t.decimal :amount
    end
  end
end
