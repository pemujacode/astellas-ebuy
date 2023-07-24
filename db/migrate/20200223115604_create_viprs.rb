class CreateViprs < ActiveRecord::Migration[6.0]
  def change
    create_table :viprs do |t|
      t.string :invoice_no
      t.string :no
      t.string :supplier
      t.date :invoice_date
      t.date :due_date
      t.string :payment_no
      t.string :currency
      t.string :requester
      t.string :approval1
      t.datetime :apv_date1
      t.string :approval2
      t.datetime :apv_date2
      t.string :approval3
      t.datetime :apv_date3
      t.string :approval4
      t.datetime :apv_date4
      t.string :remarks

      t.timestamps
    end
  end
end
