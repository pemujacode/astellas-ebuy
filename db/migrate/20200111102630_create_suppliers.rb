class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.string :code
      t.string :name
      t.string :printing_name
      t.string :address
      t.string :npwp
      t.string :phone
      t.string :email
      t.string :pic
      t.string :currency
      
      t.timestamps
    end
  end
end
