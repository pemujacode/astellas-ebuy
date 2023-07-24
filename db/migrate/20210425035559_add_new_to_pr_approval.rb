class AddNewToPrApproval < ActiveRecord::Migration[6.0]
  def change
    add_column :pr_approvals, :trans, :string
    add_column :pr_approvals, :approval_group, :string
  end
end
