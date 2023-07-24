class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :doc_type
      t.string :doc_num
      t.string :email
      t.string :remaks

      t.timestamps
    end
  end
end
