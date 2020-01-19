json.extract! maintenance_request, :id, :category, :description, :title, :property_id, :tenant_id, :user_id, :created_at, :updated_at
json.url maintenance_request_url(maintenance_request, format: :json)
