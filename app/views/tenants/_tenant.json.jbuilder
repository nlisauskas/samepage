json.extract! tenant, :id, :first_name, :last_name, :gender, :birthdate, :password_digest, :email, :property_id, :user_id, :created_at, :updated_at
json.url tenant_url(tenant, format: :json)
