class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :code
      t.string :name
      t.string :gl_account

      t.timestamps
    end
  end
end
