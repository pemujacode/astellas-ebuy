class AddSourceToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :source, :string
  end
end
