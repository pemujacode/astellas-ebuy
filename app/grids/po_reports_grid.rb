class PoReportsGrid < BaseGrid

  scope do
    PurchaseOrder
  end


  
  filter(:id, :integer, :header => 'PO No', class: 'form-control')
  filter(:po_date, :date, :range => true)
  
  filter(:supplier, :enum,
    :select => lambda {Supplier.all.map {|p| [p.name]}},
    :include_blank => true, :class => 'form-control'
  ) 




  column(:id)
  column(:po_date)
  column(:buyer)
  column(:supplier)
  column(:prepared_by)
  column(:delivery_date)
  column(:delivery_date)
  column(:grand_total)
  column(:remarks)
  column(:status)




   #params.require(:purchase_order).permit(:id,:is_vat, :remarks, :no, :supplier, :po_date, :delivery_date, :buyer, :terms_payment, :status, :prepared_by, :reviewed_by, :total, :vat, :grand_total, :approved_by, :apv1_date, :supplier, :attn, :purchase_order_items_attributes => [:purchase_order_id, :product, :no, :spesification, :req_qty, :costcenter, :price, :quantity,  :amount, :_destroy,:id] )
    








end
