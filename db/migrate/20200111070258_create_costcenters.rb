class CreateCostcenters < ActiveRecord::Migration[6.0]
  def change
    create_table :costcenters do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
