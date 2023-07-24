class CreateViprReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :vipr_reviews do |t|
      t.string :name
      t.string :title
      t.string :email
      t.decimal :plafond
      t.integer :order

      t.timestamps
    end
  end
end
