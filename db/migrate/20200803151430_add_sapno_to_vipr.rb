class AddSapnoToVipr < ActiveRecord::Migration[6.0]
  def change
    add_column :viprs, :sapno, :string
  end
end
