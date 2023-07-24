json.extract! purchase_order, :id, :no, :supplier_id, :po_date, :delivery_date, :buyer, :terms_payment, :status, :prepared_by, :reviewed_by, :total, :vat, :grand_total, :created_at, :updated_at
json.url purchase_order_url(purchase_order, format: :json)
