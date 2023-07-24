class AddStatusToSupplier < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :is_active, :boolean
  end
end
