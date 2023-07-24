json.extract! vipr_review, :id, :name, :title, :email, :plafond, :order, :created_at, :updated_at
json.url vipr_review_url(vipr_review, format: :json)
