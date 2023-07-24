class CreateAuthorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :authorizations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :costcenter
      t.string :currency
      t.string :department
      t.string :expense
      t.string :supplier
      t.string :p_request
      t.string :p_order
      t.string :p_grn

      t.timestamps
    end
  end
end
