json.extract! purchase_request, :id, :no, :user_id, :requester, :request_date, :required_date, :notes, :attachment1, :created_at, :updated_at
json.url purchase_request_url(purchase_request, format: :json)
