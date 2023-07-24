json.extract! authorization, :id, :user_id, :costcenter, :currency, :department, :expense, :supplier, :p_request, :p_order, :p_grn, :created_at, :updated_at
json.url authorization_url(authorization, format: :json)
