class ViprReportsGrid < BaseGrid

  scope do
    Vipr
  end

  
  filter(:id, :integer, :header => 'VIPR No', class: 'form-control')
  filter(:invoice_date, :date, :range => true)
  
  filter(:supplier, :enum,
    :select => lambda {Supplier.all.map {|p| [p.name]}},
    :include_blank => true, :class => 'form-control'
  ) 




  column(:id)
  column(:invoice_date)
  column(:invoice_no)
  column(:due_date)
  column(:supplier)
  column(:requester)
  column(:total)
  column(:remarks)
  column(:status)

     # params.require(:vipr).permit(:id, :attachment1, :supplier, :invoice_no, :invoice_date, :due_date, :payment_no, :currency, :requester, :approval1, :apv_date1, :approval2, :apv_date2, :approval3, :apv_date3, :approval4, :apv_date4, :subtotal, :vat, :total , :remarks, :vipr_items_attributes => [:vipr_id, :product, :no, :spesification, :req_qty, :costcenter, :price, :quantity,  :amount, :_destroy,:id] )
    

end
