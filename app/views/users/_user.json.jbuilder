json.extract! user, :id, :first_name, :last_name, :gender, :birthdate, :password_digest, :email, :property_id, :tenant_id, :created_at, :updated_at
json.url user_url(user, format: :json)
