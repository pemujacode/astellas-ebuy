json.extract! supplier, :id, :code, :name, :printing_name, :address, :npwp, :phone, :email, :pic, :currency_id, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
