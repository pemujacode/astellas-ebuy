class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
