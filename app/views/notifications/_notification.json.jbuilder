json.extract! notification, :id, :doc_type, :doc_num, :email, :remaks, :created_at, :updated_at
json.url notification_url(notification, format: :json)
