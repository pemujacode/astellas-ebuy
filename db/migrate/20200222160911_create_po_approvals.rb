class CreatePoApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :po_approvals do |t|
      t.string :requester
      t.string :apv1
      t.numeric :apv1_amount
      t.string :apv2
      t.numeric :apv2_amount
      t.string :apv3
      t.numeric :apv3_amount
      t.boolean :is_active

      t.timestamps
    end
  end
end
