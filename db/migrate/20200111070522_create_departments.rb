class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.references :costcenter, null: true, foreign_key: true
      t.references :expense, null: true, foreign_key: true

      t.timestamps
    end
  end
end
