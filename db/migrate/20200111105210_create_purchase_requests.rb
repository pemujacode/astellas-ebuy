class CreatePurchaseRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_requests do |t|
      t.string :no
      t.integer :user_id
      t.string :requester
      t.string :department
      t.string :account
      t.date :request_date
      t.date :required_date
      t.string :notes
      t.boolean :is_newgoods
      t.boolean :is_reorder


      t.timestamps
    end
  end
end
