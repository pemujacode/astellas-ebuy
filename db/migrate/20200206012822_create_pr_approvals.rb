class CreatePrApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :pr_approvals do |t|
      t.string :requester
      t.string :apv1
      t.decimal :apv1_amount
      t.string :apv2
      t.decimal :apv2_amount
      t.string :apv3
      t.decimal :apv3_amount
      t.string :apv4
      t.decimal :apv4_amount
      t.boolean :is_active
      t.string :pic

      t.timestamps
    end
  end
end
